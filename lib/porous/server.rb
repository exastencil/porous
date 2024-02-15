module Porous
  class Server
    class Router
      include Porous::Router

      def routes
        route '/', to: Home
      end
    end

    class Application
      include ::Porous::Component

      inject Router, as: :router

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
            component router
          end
        end
      end
    end

    def initialize(*args, &block)
      content = Application.new(title: 'Porous Web').to_s
      @rack = Rack::Builder.new do
        use Rack::Static, urls: ['/static']
        run do |env|
          [200, { 'content-type' => 'text/html' }, [content]]
        end
      end
    end

    def call(*args)
      @rack.call(*args)
    end
  end
end
