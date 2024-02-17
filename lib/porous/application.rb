# frozen_string_literal: true

module Porous
  class Application
    include Porous::Component

    # rubocop:disable Metrics/AbcSize
    def render
      html do
        head do
          meta charset: 'UTF-8'
          meta name: 'viewport', content: 'width=device-width, initial-scale=1.0'

          if props[:title]
            title do
              text props[:title]
            end
          end
          meta name: 'description', content: props[:description] if props[:description]

          script src: '/static/dist/runtime.js',
                 onload: 'Opal.require("native"); Opal.require("promise"); Opal.require("browser/setup/full");'
          script src: '/static/dist/reload.js'
          script src: 'https://cdn.tailwindcss.com'
        end

        body class: 'bg-gray-50 dark:bg-gray-900' do
          component Porous::Router, props: { path: props[:path], query: props[:query] }
        end
      end
    end
    # rubocop:enable Metrics/AbcSize
  end
end