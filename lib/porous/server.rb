require 'rackup'

module Porous
  class Server
    def initialize(router: Porous::Router.new)
      @router = router
    end

    def start
      app = lambda do |env|
        page = @router.lookup env['PATH_INFO']
        return [200, { 'content-type' => 'text/html' }, [page.render_html]] if page

        missing = @router.lookup '404'
        return [404, { 'content-type' => 'text/html' }, [missing.render_html]] if missing

        [404, { 'content-type' => 'text/html' }, ['404 Not found']]
      end

      Rackup::Server.start(app:)
    end
  end
end
