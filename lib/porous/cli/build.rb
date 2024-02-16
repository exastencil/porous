# frozen_string_literal: true

module Porous
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!

    namespace :build

    desc 'build', 'Build static assets'

    def build
      empty_directory 'static/dist', force: options[:force]
      transpile
    end

    no_commands do
      def transpile
        # TODO: Use Opal::Builder to generate pages, components and entities into static/dist
      end
    end
  end
end
