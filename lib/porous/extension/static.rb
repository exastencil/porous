# frozen_string_literal: true

require 'rack/static'

module Porous
  class Extension
    # The Static extension simply ensures that Rack::Static is loaded.
    # Further logic is handled by the web server.
    class Static < Porous::Extension
    end
  end
end
