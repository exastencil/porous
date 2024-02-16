# frozen_string_literal: true

module Porous
  module Component
    include VirtualDOM::DOM
    include Virtual
    include Render
    include Injection

    def self.included(base)
      base.extend Porous::Component::ClassMethods
    end

    def initialize(props = {})
      @props = props
      @root_component = self
      init_injections
      inject
      @virtual_dom = render_virtual_dom
    end

    def props
      @props || {}
    end

    def with_props(props)
      @props = props
      self
    end

    def to_s
      @virtual_dom.to_s
    end
  end
end
