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

    # Content-based closing tags: e.g. <tag>content</tag>
    %i[a abbr address article aside audio b bdi bdo blockquote body button
       canvas caption cite code colgroup data datalist dd del details dfn dialog div dl dt
       em fencedframe fieldset figcaption figure footer form
       h1 h2 h3 h4 h5 h6 head header hgroup html i iframe ins
       kbd label legend li main map mark menu meter nav noscript
       object ol optgroup option output p picture portal pre progress q rp rt ruby
       s samp script search section select slot small span strong style sub summary sup
       table tbody td template textarea tfoot th thead time title tr u ul var video].each do |tag|
      define_method(tag) do |text = nil, **attrs, &block|
        @context.tag(tag, attrs, text, &block)
      end
    end

    # Self-closing tags e.g. <hr>
    %i[area base br col embed hr img input link meta source track wbr].each do |tag|
      define_method(tag) do |**attrs|
        @context.tag(tag, attrs, self_closing: true)
      end
    end

    # Bare text node
    def text(string)
      @context.text(string)
    end
  end
end
