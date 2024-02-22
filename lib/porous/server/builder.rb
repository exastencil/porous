# frozen_string_literal: true

require 'opal/builder_scheduler/sequential'

module Porous
  module Server
    class Builder
      def initialize
        @build_queue = Queue.new
        @last_build = nil
        @latest_change = Dir.glob(File.join('**', '*.rb')).map { |f| File.mtime f }.max
      end

      def build
        components = Dir.glob(File.join('**', '*.rb')).map do |relative_path|
          modified = File.mtime relative_path
          @latest_change = modified if modified > @latest_change
          "require '#{relative_path}'"
        end
        build_string = "require 'porous'; #{components.join ";"}".gsub '.rb', ''
        builder = Opal::Builder.new scheduler: Opal::BuilderScheduler::Sequential, cache: false
        builder.build_str build_string, '(inline)'
        File.binwrite "#{Dir.pwd}/static/dist/application.js", builder.to_s
        @last_build = Time.now
        self
      end

      # rubocop:disable Metrics/AbcSize
      def start
        loop do
          sleep 0.25
          next unless @build_queue.empty?

          modified = Dir.glob(File.join('**', '*.rb')).map { |f| File.mtime f }.max
          next unless modified > @last_build

          @build_queue.push modified
          # Load for server
          Dir.glob(File.join('**', '*.rb')).map { |f| load File.expand_path("#{Dir.pwd}/#{f}") }

          # Rebuild for browser
          Thread.new { build }.join

          # Notify clients
          $socket.public 'build', @last_build.inspect
          @build_queue.clear
        end
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
