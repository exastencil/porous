# frozen_string_literal: true

module Porous
  class Application
    def initialize
      @app = Rack::Builder.new do
        use Rack::Static, urls: ['/'], root: 'static', cascade: true if defined? Rack::Static

        run do |env|
          page = Porous::Router.create_from_path env['PATH_INFO']

          if page
            page.evaluate!
            [200, { 'content-type' => 'text/html; charset=utf-8' }, page.buffer]
          else
            [404, {}, ['404 Page not found']]
          end
        end
      end
    end

    def call(env) = @app.call(env)
  end
end
