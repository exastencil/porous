module Porous
  module Page
    # Define the route according to the Router::Routes rules
    def route!
      path = route
      @routes ||= Routes.new.tap do |routes|
        routes.route path, to: self.class
      end
    end
  end
end
