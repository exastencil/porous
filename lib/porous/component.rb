require 'porous/render_context'

module Porous
  class Component
    def self.render(format = :html, &block)
      @render_html = block if format == :html
    end

    def self.inherited(subclass)
      subclass.instance_eval do
        def render_html
          if @render_html
            # New empty context
            context = RenderContext.new
            # Execute declarative script
            context.instance_eval(&@render_html)
            # Return the result in the buffer
            context.result
          else
            "<!-- #{self.name}: Not implemented -->"
          end
        end
      end
    end
  end
end
