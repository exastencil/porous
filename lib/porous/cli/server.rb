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
                  default: '127.0.0.1',
                  desc: 'The host address Porous will bind to'

    def server
      Rackup::Server.start environment: 'development', builder: <<-BUILDER
        run Porous::Server.new
      BUILDER
    end
  end
end
