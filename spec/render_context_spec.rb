# frozen_string_literal: true

RSpec.describe Porous::RenderContext do
  let(:context) { Porous::RenderContext.new }

  it "responds to HTML tags" do
    context.eval { html }
    expect(context.result).to eq '<html></html>'
  end

  it "responds to HTML tags with attributes" do
    context.eval { a(href: '/') { 'Home' } }
    expect(context.result).to eq '<a href="/">Home</a>'
  end

  it "can render nested tags" do
    context.eval do
      ul do
        li do
          a(href: '/') { 'Home' }
        end
      end
    end
    expect(context.result).to eq '<ul><li><a href="/">Home</a></li></ul>'
  end

  it "can render sequences of tags" do
    context.eval do
      h1 { 'Porous Web Engine' }
      h2 { 'Description' }
      h2 { 'Usage' }
    end

    expect(context.result).to eq '<h1>Porous Web Engine</h1><h2>Description</h2><h2>Usage</h2>'
  end

  it "can render only a text node" do
    context.eval { 'Porous Web Engine' }
    expect(context.result).to eq 'Porous Web Engine'
  end

  it "can render HTML comments" do
    context.eval do
      comment { 'Deprecated' }
    end
    expect(context.result).to eq '<!-- Deprecated -->'
  end
end
