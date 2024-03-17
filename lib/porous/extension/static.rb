# frozen_string_literal: true

module Porous
  class Extension
    # The Static extension simply ensures that Rack::Static is loaded.
    # Further logic is handled by the web server.
    class Static < Porous::Extension
      def self.on_load
        require 'rack/static'
        puts 'Serving static files from `static`…'
      end
    end
  end
end
