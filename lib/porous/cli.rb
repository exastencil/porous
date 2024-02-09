require "bundler/setup"
require "thor"
require "porous"

module Porous
  class CLI < Thor
    desc "dev", "Start a development server in the current directory"
    def dev
      puts "Starting development server in #{`pwd`}..."

      puts "Loading components…"
      Dir['./components/**/*.rb'].each { |f| require f }
      puts "Loading pages…"
      Dir['./pages/**/*.rb'].each { |f| require f }
      puts "Ready!\n"

      Porous::Server.new.start
    end
  end
end
