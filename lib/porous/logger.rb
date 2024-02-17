# frozen_string_literal: true

module Porous
  class Logger < Rack::CommonLogger
    def log(env, status, response_headers, began_at)
      super unless env['PATH_INFO'].start_with? 'static'
    end
  end
end
