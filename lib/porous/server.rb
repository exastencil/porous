# frozen_string_literal: true

module Porous
  class Server
    def initialize(*_args)
      setup_rack_app
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def setup_rack_app
      @rack = Rack::Builder.new do
        use Rack::ContentLength
        use Rack::Static, urls: ['/static']
        use Rack::CommonLogger
        use Rack::ShowExceptions
        use Rack::Lint
        use Rack::TempfileReaper

        run do |env|
          router = Porous::Router.new path: env['PATH_INFO'], query: env['QUERY_STRING']
          route = router.find_route
          page = route[:component].new(route[:params])

          [200, { 'content-type' => 'text/html' }, [
            Porous::Application.new(
              title: page.page_title,
              description: page.page_description,
              path: env['PATH_INFO'],
              query: env['QUERY_STRING']
            ).to_s
          ]]
        rescue Porous::InvalidRouteError => e
          [404, { 'content-type' => 'text/plain' }, ["404 Page not found\n", e.message]]
        rescue Porous::Error => e
          [500, { 'content-type' => 'text/plain' }, ["500 Internal Server Error\n", e.message]]
        end
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def call(*args)
      @rack.call(*args)
    end
  end
end
