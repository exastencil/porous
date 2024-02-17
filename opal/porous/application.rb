# frozen_string_literal: true

module Porous
  class Application
    include Porous::Component

    inject Porous::Router, as: :router

    def render
      body class: 'bg-gray-50 dark:bg-gray-900' do
        component router
      end
    end
  end
end
