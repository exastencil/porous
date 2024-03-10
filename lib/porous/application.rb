# frozen_string_literal: true

module Porous
  class Application
    def initialize
      @app = Rack::Builder.new do
        use Rack::Static, urls: ['/'], root: 'static', cascade: true if defined? Rack::Static

        run do |env|
          [200, {}, [env['PATH_INFO']]]
        end
      end
    end

    def call(env) = @app.call(env)
  end
end
