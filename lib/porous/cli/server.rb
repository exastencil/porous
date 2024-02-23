# frozen_string_literal: true

module Porous
  class CLI < Thor
    check_unknown_options!

    namespace :server

    desc 'server [OPTIONS]', 'Starts Porous server in production mode'
    def server # rubocop:todo Metrics/MethodLength
      Agoo::Log.configure(dir: '',
                          console: true,
                          classic: true,
                          colorize: true,
                          states: {
                            INFO: true,
                            DEBUG: false,
                            connect: true,
                            request: true,
                            response: false,
                            eval: false,
                            push: false
                          })

      Agoo::Server.init(
        80, '.',
        thread_count: 0,
        ssl_cert: 'ssl/cert.pem',
        ssl_key: 'ssl/key.pem',
        bind: [
          'http://127.0.0.1:80',
          'https://127.0.0.1:443'
        ]
      )
      Agoo::Server.use Rack::ContentLength
      Agoo::Server.use Rack::Static, urls: ['/static']

      # Socket Communication
      $socket ||= Porous::Server::Socket.new
      Agoo::Server.handle nil, '/connect', Porous::Server::Connect.new
      # Server-Side Rendering
      Agoo::Server.handle nil, '**', Porous::Server::Application.new

      Agoo::Server.start
    end
  end
end
