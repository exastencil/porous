# frozen_string_literal: true

module Porous
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!

    namespace :build

    desc 'build', 'Build static assets'

    def build
      empty_directory 'static/dist', verbose: false, force: options[:force]
      transpile
      live_reload
    end

    no_commands do
      def transpile
        # TODO: Use Opal::Builder to generate pages, components and entities into static/dist
        builder = Opal::Builder.new
        builder.build_str 'require "opal"; require "native"; require "promise"; require "browser/setup/full"',
                          '(inline)'
        File.binwrite "#{Dir.pwd}/static/dist/runtime.js", builder.to_s
      end

      # rubocop:disable Metrics/MethodLength
      def live_reload
        timestamp = Time.now.to_i.to_s
        File.write "#{Dir.pwd}/static/dist/timestamp", timestamp
        builder = Opal::Builder.new
        script = <<-BROWSER
          $document.ready do
            every 0.1 do
              Browser::HTTP.get('/static/dist/timestamp').then do |response|
                return unless response.success?
                timestamp = response.text.to_i
                TIMESTAMP ||= timestamp
                $document.location.reload if TIMESTAMP < timestamp
              end
            end
          end
        BROWSER
        builder.build_str script, '(inline)'
        File.binwrite "#{Dir.pwd}/static/dist/reload.js", builder.to_s
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
