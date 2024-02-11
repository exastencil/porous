require 'rackup'
require 'rack'

module Porous
  class Server
    def self.start
      app = Rack::Builder.new do
        # Serve files from ./public
        use Rack::Static, urls: ['/public']

        router = Porous::Router.new

        run do |env|
          if page = router.lookup(env['PATH_INFO'])
            [200, { 'content-type' => 'text/html; charset=utf-8' }, [page.render_html]]
          elsif missing = router.lookup('404')
            [404, { 'content-type' => 'text/html; charset=utf-8' }, [missing.render_html]]
          else
            [404, { 'content-type' => 'text/plain' }, ['404 Not found']]
          end
        end
      end

      Rackup::Server.start app:
    end
  end
end
