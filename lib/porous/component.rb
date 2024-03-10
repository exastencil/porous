# frozen_string_literal: true

module Porous
  class Component
    def initialize(props: {})
      @props = props
    end

    def template = proc { div }

    def render
      ::Paggio.html(&template)
    end
  end
end
