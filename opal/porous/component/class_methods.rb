# frozen_string_literal: true

module Porous
  module Component
    module ClassMethods
      def mount_to(element)
        new.mount_to(element)
      end

      def inject(klass, opts = {})
        method_name = opts[:as] || klass.to_s.downcase
        @injections ||= {}
        @injections[method_name] = klass
      end

      def injections
        @injections || {}
      end
    end
  end
end
