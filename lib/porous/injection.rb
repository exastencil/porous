# frozen_string_literal: true

module Porous
  module Injection
    def init; end

    def with_root_component(component)
      @root_component = component
      self
    end

    def inject
      @root_component.injections.each do |name, instance|
        define_singleton_method(name) do
          instance
        end
      end
      self
    end

    attr_reader :injections

    def init_injections
      @injections ||= {}
      self.class.injections.each do |name, clazz|
        unless clazz.included_modules.include?(Porous::Injection)
          raise Error, "Invalid #{clazz} class, should mixin Porous::Injection"
        end

        @injections[name] = clazz
                            .new
                            .with_root_component(@root_component)
      end
      @injections.each_value do |instance|
        instance.inject
        instance.init
      end
    end
  end
end
