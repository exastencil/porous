module Porous
  class RenderContext
    TAGS = %w(
      a abbr address area article aside audio b base bdi bdo blockquote body br button button button button canvas
      caption cite code col colgroup command datalist dd del details dfn div dl dt em embed fieldset figcaption figure
      footer form h1 h2 h3 h4 h5 h6 head header hgroup hr html i iframe img input ins kbd keygen label legend li link
      map mark menu meta meter nav noscript object ol optgroup option output p param path pre progress q rp rt ruby s
      samp script section select small source span strong style sub summary sup svg table tbody td template textarea
      tfoot th thead time title tr track u ul var video wbr
    )

    def initialize(state = {})
      @state = state
      @buffer = []
      @slots = {}
    end

    TAGS.each do |tag|
      define_method(tag) do |**props, &block|
        # Opening tag
        @buffer << "<#{tag}#{props.map { |k, v| " #{k}=\"#{v}\"" }.join}>"
        # Content
        eval &block if block
        # Closing tag
        @buffer << "</#{tag}>"
        # Return nil to indicate this wasn't a text node
        nil
      end
    end

    # Comments need a special case because they're opening and closing tags are non-standard
    def comment(**props, &block)
      # Opening tag
      @buffer << "<!-- "
      # Content
      eval &block if block
      # Closing tag
      @buffer << " -->"
      # Return nil to indicate this wasn't a text node
      nil
    end

    # Text nodes need a special case when they are not the only child
    def text(content)
      # Content
      @buffer << content
      # Return nil so the text returned doesn't render twice
      nil
    end

    def eval(slots = {}, &block)
      @slots = @slots.merge slots
      output = instance_eval &block

      # Text nodes
      if output.is_a? String
        @buffer << output
      end
    end

    def slot(name = :default, &placeholder)
      if @slots[name]
        # Slot provided by a parent component
        eval(@slots, &@slots[name])
      elsif placeholder
        # Default content for slot exists
        eval(@slots, &placeholder)
      else
        # Slot without default content not provided
        raise "Missing slot for component!"
      end
    end

    def render(component_or_class, &slot)
      klass = component_or_class.is_a?(Component) ? component_or_class.class : component_or_class
      if slot
        @buffer << klass.render_html({ default: slot })
      else
        @buffer << klass.render_html
      end
    end

    def result
      @buffer.join
    end
  end
end
