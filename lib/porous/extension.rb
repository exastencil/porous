# frozen_string_literal: true

module Porous
  class Extension
    def self.loaded?(extension)
      name = extension.to_sym
      ::Porous::Extension.const_defined?(name) && ::Porous::Extension.const_get(name) < Porous::Extension
    end
  end
end
