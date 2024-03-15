# frozen_string_literal: true

module Porous
  class Page < Component
    def initialize(path = '/', props: {})
      parse_params path
      super(props: props, context: RenderContext.new(self))
    end

    def self.metadata(route: '/', title: nil, description: nil)
      @__page_metadata = {
        route: route,
        title: title,
        description: description
      }
    end

    def self.page_metadata
      @__page_metadata
    end

    def evaluate!
      @context.clear
      component Porous::Preamble, **page_metadata do
        content
      end
    end

    def buffer
      @context.buffer
    end

    protected

    def page_metadata = self.class.page_metadata

    def parse_params(_path)
      @params = {}
    end
  end
end
