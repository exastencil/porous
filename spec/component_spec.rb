# frozen_string_literal: true

RSpec.describe Porous::Component do
  class SimpleComponent < Porous::Component
    render(:html) { 'Component' }
  end

  class ComplexComponent < Porous::Component
    render :html do
      ul do
        li { a(href: '/') { 'Home' } }
        li { a(href: '/login') { 'Login' } }
      end
    end
  end

  class PageComponent < Porous::Component
    render :html do
      h1 { 'Porous Application' }
      render ComplexComponent
    end
  end

  class Link < Porous::Component
    render(:html) { a(href: '/') { 'Text' } }
  end

  class Navigation < Porous::Component
    render :html do
      nav do
        render Link
        render Link
      end
    end
  end

  it "can be rendered to HTML" do
    expect(SimpleComponent.render_html).to eq 'Component'
    expect(ComplexComponent.render_html).to eq '<ul><li><a href="/">Home</a></li><li><a href="/login">Login</a></li></ul>'
  end

  it "can render nested components" do
    expect(PageComponent.render_html).to eq '<h1>Porous Application</h1><ul><li><a href="/">Home</a></li><li><a href="/login">Login</a></li></ul>'
    expect(Navigation.render_html).to eq '<nav><a href="/">Text</a><a href="/">Text</a></nav>'
  end

  class Card < Porous::Component
    render :html do
      div(class: 'card') do
        slot do
          div(class: 'card-body')
        end
      end
    end
  end

  it "can have slots with default content" do
    expect(Card.render_html).to eq '<div class="card"><div class="card-body"></div></div>'
  end

  class AceSpades < Porous::Component
    render :html do
      render Card do
        div(class: 'card-title') { 'A' }
      end
    end
  end

  it "can render other components and provide them with content" do
    expect(AceSpades.render_html).to eq '<div class="card"><div class="card-title">A</div></div>'
  end
end
