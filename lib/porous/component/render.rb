module Porous
  module Component
    module Render
      def render
        raise Error, "Implement #render in #{self.class} component"
      end

      def before_render
      end

      def render_virtual_dom
        before_render
        @__virtual_nodes__ = []
        render
        to_vnode
      end
    end
  end
end
