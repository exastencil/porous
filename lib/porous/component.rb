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

    def button
      @context.tag(:button)
    end
  end
end
