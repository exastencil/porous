# frozen_string_literal: true

module Porous
  module Server
    class Connect
      # Only used for WebSocket or SSE upgrades.
      def call(env)
        if env['rack.upgrade?'].nil?
          [404, {}, []]
        else
          $socket ||= Socket.new
          env['rack.upgrade'] = $socket
          [200, {}, []]
        end
      end
    end
  end
end
