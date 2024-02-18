# frozen_string_literal: true

module Porous
  class Server
    MONITORING = %w[components pages].freeze

    def call(env)
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
