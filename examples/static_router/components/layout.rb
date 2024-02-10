class Layout < Porous::Component
  def self.render
    html do
      head do
        title { 'Static Routing Example' }
      end

      body do
        h1 { 'Porous Web Engine' }
        yield if block_given?
      end
    end
  end
end
