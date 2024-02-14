module Porous
  module Component
    include VirtualDOM::DOM
    include Virtual
    include Render
    include Injection

    def self.included(base)
      base.extend Porous::Component::ClassMethods
    end

    def initialize
      @root_component = self
      init_injections
      inject
      @virtual_dom = render_virtual_dom
      self
    end

    attr_reader :props

    def with_props(props)
      @props = props
      self
    end
  end
end
