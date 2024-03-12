# frozen_string_literal: true

module Porous
  class Page < Component
    def initialize(path = '/', props: {})
      parse_params path
      super(props: props, context: RenderContext.new(self))
    end

    def route = '/'
    def page_title = nil
    def page_description = nil

    def parse_params(_path)
      @params = {}
    end
  end
end
