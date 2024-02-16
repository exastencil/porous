# frozen_string_literal: true

module Porous
  class Server
    class Router
      include Porous::Router
    end

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
            component Router, props: { path: props[:path], query: props[:query] }
          end
        end
      end
    end

    def initialize(*_args)
      @rack = Rack::Builder.new do
        use Rack::Static, urls: ['/static']
        run do |env|
          [
            200,
            { 'content-type' => 'text/html' },
            [
              Application.new(title: 'Porous Web', path: env['PATH_INFO'], query: env['QUERY_STRING']).to_s
            ]
          ]
        end
      end
    end

    def call(*args)
      @rack.call(*args)
    end
  end
end
