# frozen_string_literal: true

module Porous
  class Preamble < Component
    # Sets the title of the document
    property :title

    # Set the description of the document
    property :description

    # Renders an application shell based on your configuration.
    # The block passed to this method should contain the body
    # tag for the current page.
    #
    # @param [Block] &body
    def content
      html do
        head do
          meta charset: 'utf-8'
          meta name: 'viewport', content: 'width=device-width,initial-scale=1'

          title @title if @title
          meta name: 'description', content: @description if @description
          link rel: 'icon', href: '/favicon.svg', type: 'image/svg+xml'
        end

        yield
      end
    end
  end
end
