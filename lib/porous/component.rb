# frozen_string_literal: true

module Porous
  class Component
    def initialize(props: {}, context: nil)
      @context = context || RenderContext.new(self)
      @props = props
    end

    def content = nil

    def evaluate!
      @context.clear if @context.root == self
      content
    end

    def render!
      @context.render
    end

    protected

    def button(text = nil, **attrs, &block)
      @context.tag(:button, attrs, text, &block)
    end

    def div(text = nil, **attrs, &block)
      @context.tag(:div, attrs, text, &block)
    end

    def em(text = nil, **attrs, &block)
      @context.tag(:em, attrs, text, &block)
    end

    def h1(text = nil, **attrs, &block)
      @context.tag(:h1, attrs, text, &block)
    end

    def p(text = nil, **attrs, &block)
      @context.tag(:p, attrs, text, &block)
    end

    def text(string)
      @context.text(string)
    end
  end
end
