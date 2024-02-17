module Porous
  class Router
    include Porous::Component

    attr_reader :params

    def initialize
      @routes = Routes.new
      # Extract the routes from all Pages
      # Object.descendants.each { |klass| puts klass if klass.is_a?(Class) }
      Object.descendants.select { |c| c.is_a?(Class) && c.included_modules.include?(Porous::Page) }.each do |klass|
        # puts "Included in: #{klass}"
        next if klass.to_s.start_with? '#<Class:' # skip singleton classes

        @routes.combine klass.new.route!
      end

      raise Error, 'No Porous::Page components found!' if @routes.routes.empty?

      find_route
      parse_url_params
      add_listeners
    end

    def self.included(base)
      base.extend(Porous::Component::ClassMethods)
      Component.module_eval do
        unless respond_to?(:__a)
          alias_method :__a, :a
          define_method(:a) do |params = {}, &block|
            params = { onclick: ->(e) {
                                  router.go_to(e.target.pathname) unless params[:target] == "_blank"
                                } }.merge(params)
            __a(params, &block)
          end
        end
      end
    end

    def add_listeners
      if Browser::History.supported?
        # TODO: Fix routing (navigating)
        # Browser.on_pop_state { find_route; parse_url_params; render! }
        # Browser.hash_change { find_route; parse_url_params; render! }
      end
    end

    def route(*params, &block)
      @routes.route(*params, &block)
    end

    def find_route
      @routes.routes.each do |route|
        next unless path.match(route[:regex])
        return go_to(url_for(route[:redirect_to])) if route[:redirect_to]

        return @route = route
      end
      raise Error, "Can't find route for url"
    end

    def find_component(route)
      call_on_enter_callback(route)
      @component_props = route[:component_props]
      route[:component]
    end

    def render
      component find_component(@route), props: @component_props if @route
    end

    def call_on_enter_callback(route)
      return unless route[:on_enter]

      if route[:on_enter].respond_to?(:call)
        route[:on_enter].call
      end
    end

    def go_to(path)
      Browser.push_state(path)
      find_route
      parse_url_params
      render!
      false
    end

    def parse_url_params
      @params = compotent_url_params
      query[1..-1].split('&').each do |param|
        key, value = param.split('=')
        @params[Browser.decode_uri_component(key)] = Browser.decode_uri_component(value)
      end unless query.empty?
    end

    def compotent_url_params
      Hash[@route[:params].zip(path.match(@route[:regex])[1..-1])]
    end

    def url_for(name, params = nil)
      route = @routes.routes.find do |r|
        case name
        when String
          r[:name] == name || r[:path] == name
        when Object
          r[:component] == name
        else
          false
        end
      end
      route ? url_with_params(route, params) : raise(Error, "Route '#{name}' not found.")
    end

    def query
      $document.location.query
    end

    def path
      $document.location.path
    end

    def current_url?(name)
      path == url_for(name, params)
    end

    def url_with_params(route, params)
      path = route[:path]
      params.each do |key, value|
        path = path.gsub(":#{key}", "#{value}")
      end if params
      path
    end
  end
end
