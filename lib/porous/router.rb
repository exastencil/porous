# frozen_string_literal: true

require 'singleton'

module Porous
  class Router
    include Singleton

    # Simply find the first page class that has a route that could match this path
    def self.find_by_path(path)
      segments = path.split '/'
      ObjectSpace.each_object(Class).select { |c| c < Porous::Page }.find do |p|
        route_segments = p.page_metadata[:route].split '/'
        # Needs matching segment length
        next unless route_segments.length == segments.length

        # Each segment should match or be a params
        route_segments.each_with_index.all? { |s, i| s == segments[i] || s.start_with?(':') }
      end
    end

    # Given a path, find the corresponding page class and create an instance of it with params extracted from the path
    def self.create_from_path(path)
      page_class = find_by_path(path)
      return unless page_class

      segments = path.split '/'
      route_segments = page_class.page_metadata[:route].split '/'

      viable_params = route_segments.each_with_index.select { |s, _| s.start_with? ':' }
      params = viable_params.to_h { |str, i| [str[1..].to_sym, segments[i]] }

      page_class.new params: params
    end
  end
end
