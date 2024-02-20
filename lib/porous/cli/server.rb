# frozen_string_literal: true

module Porous
  class CLI < Thor
    check_unknown_options!

    namespace :server

    desc 'server [OPTIONS]', 'Starts Porous server'
    method_option :port,
                  aliases: :p,
                  type: :numeric,
                  default: 9292,
                  desc: 'The port Porous will listen on'

    method_option :host,
                  aliases: :h,
                  type: :string,
                  default: 'localhost',
                  desc: 'The host address Porous will bind to'

    def server # rubocop:todo Metrics/MethodLength
      Agoo::Log.configure(dir: '',
                          console: true,
                          classic: true,
                          colorize: true,
                          states: {
                            INFO: true,
                            DEBUG: false,
                            connect: false,
                            request: true,
                            response: true,
                            eval: true,
                            push: true
                          })

      Agoo::Server.init 9292, Dir.pwd, thread_count: 1
      Agoo::Server.use Rack::ContentLength
      Agoo::Server.use Rack::Static, urls: ['/static']
      Agoo::Server.use Rack::ShowExceptions
      Agoo::Server.use Rack::TempfileReaper

      # Socket Communication
      $socket ||= Porous::Server::Socket.new
      Agoo::Server.handle :GET, '/connect', Porous::Server::Connect.new
      # Server-Side Rendering
      Agoo::Server.handle nil, '**', Porous::Server::Application.new
      Agoo::Server.start
      # Live Reload Builder
      Server::Builder.new.build.start
    end
  end
end
