# frozen_string_literal: true

RSpec.describe Porous::RenderContext do
  let(:context) { Porous::RenderContext.new }

  it "responds to HTML tags" do
    context.instance_eval { html }
    expect(context.result).to eq '<html></html>'
  end

  it "responds to HTML tags with attributes" do
    context.instance_eval { a(href: '/') { 'Home' } }
    expect(context.result).to eq '<a href="/">Home</a>'
  end

  it "can render nested tags" do
    context.instance_eval do
      ul do
        li do
          a(href: '/') { 'Home' }
        end
      end
    end
    expect(context.result).to eq '<ul><li><a href="/">Home</a></li></ul>'
  end

  it "can render sequences of tags" do
    context.instance_eval do
      h1 { 'Porous Web Engine' }
      h2 { 'Description' }
      h2 { 'Usage' }
    end

    expect(context.result).to eq '<h1>Porous Web Engine</h1><h2>Description</h2><h2>Usage</h2>'
  end
end
