# frozen_string_literal: true

module Porous
  class Application
    include Porous::Component

    def render
      body class: 'bg-gray-50 dark:bg-gray-900' do
        component Porous::Router
      end
    end
  end
end
