# frozen_string_literal: true

module Porous
  class Server
    MONITORING = %w[components pages].freeze

    def initialize(*_args)
      MONITORING.each { |path| FileUtils.mkdir_p path }
      start_live_reload
      setup_rack_app
    end

    def start_live_reload
      opts = { only: /\.rb$/, relative: true }
      @listener = Listen.to(*MONITORING, opts) do |modified, added, _removed|
        (modified + added).each do |file|
          load File.expand_path("#{Dir.pwd}/#{file}")
        end
        # Signal a browser refresh
        File.write "#{Dir.pwd}/static/dist/timestamp", Time.now.to_i.to_s
      end
      @listener.start
      at_exit { @listener.stop }
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
