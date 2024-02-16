# frozen_string_literal: true

module Porous
  module Router
    include Porous::Component

    attr_reader :params

    def initialize(props = {})
      @props = props
      @routes = Routes.new

      # Extract the routes from all Pages
      ObjectSpace.each_object(Class).select { |c| c.included_modules.include? Porous::Page }.each do |klass|
        # TODO: Figure out where these classes are coming from
        # puts "#{klass}: #{klass.ancestors.first} (#{klass.respond_to? :new})"
        next if klass.to_s.start_with? '#<Class:' # skip singleton classes

        @routes.combine klass.new.route!
      end

      raise Error, 'No Porous::Page components found!' if @routes.routes.empty?

      find_route
      parse_url_params
    end

    def self.included(base)
      base.extend(Porous::Component::ClassMethods)
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

      return unless route[:on_enter].respond_to?(:call)

      route[:on_enter].call
    end

    def go_to(path)
      # Figure out how to change path
      @props[:path] = path
      find_route
      parse_url_params
      render!
      false
    end

    def parse_url_params
      @params = component_url_params
      return if query.empty?

      query[1..].split('&').each do |param|
        key, value = param.split('=')
        @params[key] = value
      end
    end

    def component_url_params
      @route[:params].zip(path.match(@route[:regex])[1..]).to_h
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
      @props ? @props[:query] : '' # Browser.query
    end

    def path
      @props ? @props[:path] : '/' # @props[:path] # Browser.path
    end

    def current_url?(name)
      path == url_for(name, params)
    end

    def url_with_params(route, params)
      path = route[:path]
      params&.each do |key, value|
        path = path.gsub(":#{key}", value.to_s)
      end
      path
    end
  end
end
