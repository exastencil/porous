# frozen_string_literal: true

module Porous
  class Extension
    def self.loaded
      subclasses
    end

    # Checks if an extension has been loaded. The implementation guards
    # against the case where the class isn't loaded yet and thus the
    # constant isn't defined.
    def self.loaded?(extension)
      name = extension.to_sym
      return false unless const_defined?(name)

      loaded.include? ::Porous::Extension.const_get(name)
    end

    # Callback to execute when an extension is loaded.
    # Override this as needed in your extension.
    # Default implementation outputs to the console that the module was loaded.
    def self.on_load
      puts "Loaded extension: #{name}"
    end

    # Triggers the on_load callback on the subclass.
    # This should fire automatically when the extension is loaded and avoids
    # placing arbitrary code before the class definition in the file.
    def self.inherited(subclass)
      # See: https://stackoverflow.com/questions/7906266
      TracePoint.trace(:end) do |t|
        if subclass == t.self
          subclass.on_load
          t.disable
        end
      end
      super
    end
  end
end
