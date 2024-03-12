# frozen_string_literal: true

module Porous
  class RenderContext
    attr_reader :root

    def initialize(root)
      @buffer = []
      @root = root
    end

    # Render in the server context simply means to concatenate the HTML
    # in the buffer of the render context.
    #
    def render
      @buffer.join
    end

    def clear
      @buffer = []
    end

    def tag(symbol)
      @buffer << "<#{symbol}>"
      yield if block_given?
      @buffer << "</#{symbol}>"
    end
  end
end
