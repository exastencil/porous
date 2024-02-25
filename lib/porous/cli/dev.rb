# frozen_string_literal: true

module Porous
  class CLI < Thor
    check_unknown_options!

    namespace :dev

    desc 'dev', 'Starts a Porous development server'
    def dev # rubocop:todo Metrics/MethodLength
      empty_directory 'static/dist', verbose: false, force: options[:force]

      Agoo::Log.configure(
        dir: '',
        console: true,
        classic: true,
        colorize: true,
        states: {
          INFO: true,
          DEBUG: false,
          connect: false,
          request: true,
          response: false,
          eval: false,
          push: false
        }
      )

      Agoo::Server.init 9292, 'static', thread_count: 1, root_first: true
      Agoo::Server.use Rack::ContentLength
      Agoo::Server.use Rack::ShowExceptions

      # Socket Communication
      $socket ||= Porous::Server::Socket.new
      Agoo::Server.handle nil, '/connect', Porous::Server::Connect.new
      # Server-Side Rendering
      Agoo::Server.handle nil, '**', Porous::Server::Application.new
      Agoo::Server.start
      # Live Reload Builder
      Server::Builder.new.build.start
    end
  end
end
