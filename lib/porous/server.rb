# frozen_string_literal: true

module Porous
  class Application
    include Porous::Component

    def render
      html do
        head do
          title do
            text props[:title]
          end
          meta charset: 'UTF-8'
          meta name: 'viewport', content: 'width=device-width, initial-scale=1.0'
          script src: 'https://cdn.tailwindcss.com'
        end

        body class: 'bg-gray-50 dark:bg-gray-900' do
          component Porous::Router, props: { path: props[:path], query: props[:query] }
        end
      end
    end
  end

  class Server
    MONITORING = %w[components pages].freeze

    def initialize(*_args)
      @queue = Queue.new
      start_live_reload
      setup_rack_app
    end

    def start_live_reload
      MONITORING.each { |path| FileUtils.mkdir_p path }
      opts = {
        only: /\.rb$/,
        relative: true
      }
      @listener = Listen.to(*MONITORING, opts) do |modified, added, _removed|
        (modified + added).each do |file|
          load File.expand_path("#{Dir.pwd}/#{file}")
        end
        setup_rack_app
      end
      @listener.start
      at_exit { @listener.stop }
    end

    def setup_rack_app
      @rack = Rack::Builder.new do
        use Rack::Static, urls: ['/static']
        run do |env|
          # Build a router to check for a valid route
          Porous::Router.new path: env['PATH_INFO'], query: env['QUERY_STRING']
          [200, { 'content-type' => 'text/html' },
           [Application.new(title: 'Porous Web', path: env['PATH_INFO'], query: env['QUERY_STRING']).to_s]]
        rescue Porous::InvalidRouteError => e
          [404, { 'content-type' => 'text/plain' },
           ["404 Page not found\n", e.message]]
        rescue Porous::Error => e
          [500, { 'content-type' => 'text/plain' },
           ["500 Internal Server Error\n", e.message]]
        end
      end
    end

    def call(*args)
      @rack.call(*args)
    end
  end
end
