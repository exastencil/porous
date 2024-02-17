# frozen_string_literal: true

module Porous
  # rubocop:disable Metrics/ClassLength
  class Router
    include Porous::Component

    attr_reader :params

    def initialize
      @routes = Routes.new
      # Extract the routes from all Pages
      # Object.descendants.each { |klass| puts klass if klass.is_a?(Class) }
      Object.descendants.select { |c| c.is_a?(Class) && c.included_modules.include?(Porous::Page) }.each do |klass|
        # puts "Included in: #{klass}"
        # next if klass.to_s.start_with? '#<Class:' # skip singleton classes

        @routes.combine klass.new.route!
      end

      raise Error, 'No Porous::Page components found!' if @routes.routes.empty?

      find_route
      parse_url_params
      add_listeners
    end

    # Handle anchor tags with router (requires router to be injected)
    Component.module_eval do
      unless respond_to?(:__a)
        alias_method :__a, :a
        define_method(:a) do |params = {}, &block|
          if params['href'].include?('//') || params['target'] == '_blank'
            # Retain behaviour
          else
            href = params['href']
            params[:onclick] = lambda { |e|
              e.prevent
              raise Error, 'No router to handle navigation. Did you `inject Porous::Router`' unless router

              router.go_to(href)
            }
          end
          __a(params, &block)
        end
      end
    end

    def add_listeners
      return unless Browser::History.supported?

      $window.on(:popstate) do
        find_route
        parse_url_params
        render!
      end
      $window.on(:hashchange) do
        find_route
        parse_url_params
        render!
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

      return unless route[:on_enter].respond_to?(:call)

      route[:on_enter].call
    end

    def go_to(path)
      $window.history.push path
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
        @params[Browser.decode_uri_component(key)] = Browser.decode_uri_component(value)
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
      $window.location.query
    end

    def path
      $window.location.path
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
  # rubocop:enable Metrics/ClassLength
end
