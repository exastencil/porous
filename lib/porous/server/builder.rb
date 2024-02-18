# frozen_string_literal: true

module Porous
  class Server
    class Builder
      def initialize
        @mutex = Mutex.new
        @last_build = nil
        @latest_change = nil
      end

      def build
        components = Dir.glob(File.join('**', '*.rb')).map do |relative_path|
          "require '#{relative_path}'"
        end
        build_string = "require 'porous'; #{components.join ";"}".gsub '.rb', ''
        builder = Opal::Builder.new
        builder.build_str build_string, '(inline)'
        File.binwrite "#{Dir.pwd}/static/dist/application.js", builder.to_s
        @last_build = Time.now
        self
      end

      def start
        opts = { only: /\.rb$/, relative: true }
        @listener = Listen.to(*Porous::Server::MONITORING, opts) do |modified, added, _removed|
          # Load for server
          (modified + added).each do |file|
            load File.expand_path("#{Dir.pwd}/#{file}")
          end
          # Rebuild for browser
          Thread.new do
            build
            # Notify clients
            @mutex.synchronize do
              Agoo.publish 'build', @last_build.inspect
            end
          end
        end
        @listener.start
        at_exit { @listener.stop }
      end
    end
  end
end
