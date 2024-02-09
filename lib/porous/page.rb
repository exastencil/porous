module Porous
  class Page
    # Defaults to root route ('/') – override for each subclass
    def self.route; []; end

    # By default it renders nothing
    def html; nil; end
  end
end
