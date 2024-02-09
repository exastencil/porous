module Porous
  class Router
    attr_reader :routes

    def initialize(klasses = nil)
      klasses ||= ObjectSpace.each_object(Class).select { |klass| klass < Porous::Page }
      @routes = klasses.map { |klass| [klass.route.join('/'), klass] }.to_h
    end

    # Given a path scans the routes and finds the first valid one
    def lookup(path)
      segments = (path[0] == '/' ? path[1..-1] : path).split('/')
      key = @routes.keys.find { |key| puts segments; key.split('/') == segments }
      @routes[key]
    end
  end
end
