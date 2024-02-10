module Porous
  class RenderContext
    TAGS = %w(
      a abbr address area article aside audio b base bdi bdo blockquote body br button button button button canvas
      caption cite code col colgroup command datalist dd del details dfn div dl dt em embed fieldset figcaption figure
      footer form h1 h2 h3 h4 h5 h6 head header hgroup hr html i iframe img input ins kbd keygen label legend li link
      map mark menu meta meter nav noscript object ol optgroup option output p param pre progress q rp rt ruby s samp
      script section select small source span strong style sub summary sup table tbody td template textarea tfoot th
      thead time title tr track u ul var video wbr
    )

    def initialize(state = {})
      @state = state
      @buffer = []
    end

    TAGS.each do |tag|
      define_method(tag) do |**props, &block|
        # Opening tag
        @buffer << "<#{tag}#{props.map { |k, v| " #{k}=\"#{v}\"" }.join}>"

        # Content
        if block
          output = block.call

          # Text nodes
          if output.is_a? String
            @buffer << output
          end
        end

        # Closing tag
        @buffer << "</#{tag}>"
      end
    end

    def result
      @buffer.join
    end
  end
end
