# frozen_string_literal: true

module Porous
  class Application
    def initialize
      @app = Rack::Builder.new do
        use Rack::Static, urls: ['/'], root: 'static', cascade: true if defined? Rack::Static

        run do |env|
          # Server-side rendering
          page = ObjectSpace.each_object(Class).select { |c| c < Porous::Page }.find do |p|
            p.route == env['PATH_INFO']
          end

          if page
            [200, { 'content-type' => 'text/html; charset=utf-8' }, [page.new(env['PATH_INFO']).render]]
          else
            [404, {}, ['404 Page not found']]
          end
        end
      end
    end

    def call(env) = @app.call(env)
  end
end
