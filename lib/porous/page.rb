module Porous
  class Page < Component
    # Defaults to root route ('/') – override for each subclass
    def self.route; []; end
  end
end
