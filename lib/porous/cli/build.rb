# frozen_string_literal: true

module Porous
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!

    namespace :build

    def self.exit_on_failure?
      true
    end

    desc 'build', 'Build static assets'
    def build
      empty_directory 'static/dist', verbose: false, force: options[:force]
      Porous::Server::Builder.new.build
    end
  end
end
