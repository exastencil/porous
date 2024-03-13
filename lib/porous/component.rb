# frozen_string_literal: true

module Porous
  class Component
    def initialize(props: {}, context: nil)
      @context = context || RenderContext.new(self)
      @props = props
    end

    def content = nil

    def evaluate!(&block)
      @context.clear if @context.root == self
      content(&block)
    end

    def render!
      @context.render
    end

    protected

    def component(component_class_or_instance, &block)
      component_instance = if component_class_or_instance.is_a?(Class)
                             component_class_or_instance.new(context: @context)
                           else
                             component_class_or_instance
                           end
      component_instance.evaluate!(&block)
    end

    def a(text = nil, **attrs, &block)
      @context.tag(:a, attrs, text, &block)
    end

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
