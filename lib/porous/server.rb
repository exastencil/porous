module Porous
  class Server
    def initialize(*args, &block)
      @rack = Rack::Builder.new do
        use Rack::Static, urls: ['/static']
        run do |env|
          [200, { 'content-type' => 'text/html' }, ['hello world']]
        end
      end
    end

    def call(*args)
      @rack.call(*args)
    end
  end
end
