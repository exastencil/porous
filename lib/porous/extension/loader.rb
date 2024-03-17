# frozen_string_literal: true

module Porous
  class Extension
    # The Loader extension dynamically loads application code at the
    # correct point in execution based on the environment. While developing
    # code should be loaded anew in each forked process, but in production
    # it should be loaded once initially as it won't change.
    class Loader < Porous::Extension
      def self.on_load
        # Load application-specific code (once)
        Dir.glob(File.join('{components,pages}', '**', '*.rb')).each do |relative_path|
          require File.expand_path("#{Dir.pwd}/#{relative_path}")
        end
      end
    end
  end
end
