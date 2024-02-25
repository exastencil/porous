# frozen_string_literal: true

module Porous
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!

    namespace :build

    def self.exit_on_failure?
      true
    end

    desc 'build ENV', 'Build static assets for environment (default: development)'
    def build(env = :development)
      empty_directory 'static', verbose: false, force: options[:force]
      Porous::Server::Builder.new(env.to_sym).build
    end
  end
end
