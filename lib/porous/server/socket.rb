# frozen_string_literal: true

module Porous
  class Server
    class Socket
      # TODO: Maintain connections
      def self.call(env)
        if env['rack.upgrade?'].nil?
          [404, {}, []]
        else
          env['rack.upgrade'] = Socket
          [200, {}, []]
        end
      end

      def self.on_open(client)
        client.subscribe('build')
      end

      def self.on_close(client)
        client.unsubscribe('build')
      end
    end
  end
end
