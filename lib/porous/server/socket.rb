# frozen_string_literal: true

module Porous
  module Server
    class Socket
      def initialize
        @clients = []
        @mutex = Mutex.new
      end

      def on_open(client)
        @mutex.synchronize do
          @clients << client
        end
      end

      def on_close(client)
        @mutex.synchronize do
          @clients.delete(client)
        end
      end

      def on_drained(_client); end

      def on_message(client, data)
        client.write("Handler says #{data}")
      end

      def public(channel, message)
        output = "#{channel}|#{message}"
        @mutex.synchronize do
          @clients.each do |c|
            c.write output
          end
        end
      end
    end
  end
end
