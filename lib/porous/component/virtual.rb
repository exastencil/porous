module Porous
  module Component
    module Virtual
      # Used to render nested components (no caching on server)
      def component(comp, opts = {})
        raise Error, "Component is nil in #{self.class} class" if comp.nil?

        @__virtual_nodes__ ||= []
        comp = (comp.is_a?(Class) ? comp.new(opts[:props] || {}) : comp)
               .with_root_component(@root_component)
               .inject
        comp.init
        @__virtual_nodes__ << comp.render_virtual_dom
        self
      end
    end
  end
end
