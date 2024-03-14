# frozen_string_literal: true

module Porous
  class Application
    def initialize
      @app = Rack::Builder.new do
        use Rack::Static, urls: ['/'], root: 'static', cascade: true if defined? Rack::Static

        run do |env|
          # Server-side rendering
          page_class = ObjectSpace.each_object(Class).select { |c| c < Porous::Page }.find do |p|
            p.route == env['PATH_INFO']
          end

          if page_class
            page = page_class.new env['PATH_INFO']
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
