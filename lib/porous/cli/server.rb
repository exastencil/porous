# frozen_string_literal: true

module Porous
  class CLI < Thor
    check_unknown_options!

    namespace :server

    desc 'server [OPTIONS]', 'Starts Porous server'
    method_option :port,
                  aliases: :p,
                  type: :numeric,
                  default: 9292,
                  desc: 'The port Porous will listen on'

    method_option :host,
                  aliases: :h,
                  type: :string,
                  default: 'localhost',
                  desc: 'The host address Porous will bind to'

    MONITORING = %w[components pages].freeze

    def server
      MONITORING.each { |path| FileUtils.mkdir_p path }
      build
      start_live_reload
      Rackup::Server.start environment: 'none', app: Porous::Server.new
    end

    no_commands do
      def start_live_reload
        opts = { only: /\.rb$/, relative: true }
        @listener = Listen.to(*MONITORING, opts) do |modified, added, _removed|
          # Load for server
          (modified + added).each do |file|
            load File.expand_path("#{Dir.pwd}/#{file}")
          end
          # Rebuild for browser
          Thread.new { build }
        end
        @listener.start
        at_exit { @listener.stop }
      end
    end
  end
end
