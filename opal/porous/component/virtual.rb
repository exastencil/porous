# frozen_string_literal: true

module Porous
  module Component
    module Virtual
      # Memoizes instances of sub-components for re-rendering
      def cache_component(component, &block)
        @cache_component ||= {}
        @cache_component_counter ||= 0
        @cache_component_counter += 1
        cache_key = "#{component}-#{@cache_component_counter}"
        @cache_component[cache_key] || @cache_component[cache_key] = block.call
      end

      # Used to render nested components
      def component(comp, opts = {})
        raise Error, "Component is nil in #{self.class} class" if comp.nil?

        @__virtual_nodes__ ||= []
        @__virtual_nodes__ << cache_component(comp) do
          comp = (comp.is_a?(Class) ? comp.new : comp)
                 .with_root_component(@root_component)
                 .inject
          comp.init
          comp
        end.with_props(opts[:props] || {}).render_virtual_dom
        self
      end

      def hook(mthd)
        VirtualDOM::Hook.method(method(mthd))
      end

      def unhook(mthd)
        VirtualDOM::UnHook.method(method(mthd))
      end
    end
  end
end
