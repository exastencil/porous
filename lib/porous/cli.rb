require "bundler/setup"
require "thor"
require "porous"

module Porous
  class CLI < Thor
    desc "dev", "Start a development server in the current directory"
    def dev
      puts "Starting development server in #{`pwd`}..."

      if Dir['./components/**/*.rb'].any?
        puts "Loading components…"
        Dir['./components/**/*.rb'].each { |f| require f }
      else
        puts "No components found!"
      end

      if Dir['./pages/**/*.rb'].any?
        puts "Loading pages…"
        Dir['./pages/**/*.rb'].each { |f| require f }
      else
        puts "No pages found!"
      end

      puts "Ready!\n"

      Porous::Server.new.start
    end
  end
end
