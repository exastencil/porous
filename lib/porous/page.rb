# frozen_string_literal: true

module Porous
  module Page
    # Define the route according to the Router::Routes rules
    def route!
      path = route
      @route ||= Routes.new.tap do |routes|
        routes.route path, to: self.class
      end
    end
  end
end
