# frozen_string_literal: true

module Porous
  class CLI < Thor
    check_unknown_options!

    namespace :dev

    desc 'dev', 'Starts a Porous development server'
    def dev # rubocop:todo Metrics/MethodLength, Metrics/AbcSize
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
          request: false,
          response: false,
          eval: true,
          push: true
        }
      )

      Agoo::Server.init 9292, Dir.pwd, thread_count: 1
      Agoo::Server.use Rack::ContentLength
      Agoo::Server.use Rack::Static, urls: ['/static']
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
