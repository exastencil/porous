class Layout < Porous::Component
  render :html do
    html do
      head do
        title { 'Static Routing Example' }
      end

      body do
        h1 { 'Porous Web Engine' }

        slot do
          p { 'Place content here' }
        end
      end
    end
  end
end
