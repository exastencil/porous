# frozen_string_literal: true

module Porous
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!

    namespace :new

    desc 'new PROJECT_NAME', 'Create Porous app'

    method_option :force,
                  aliases: :f,
                  type: :boolean,
                  default: false,
                  desc: 'Force overwriting files'

    def new(project_dir)
      directory('template', project_dir, project_name: project_dir)

      inside project_dir do
        run 'bundle install'
      end
    end

    def self.source_root
      File.dirname(__FILE__)
    end
  end
end
