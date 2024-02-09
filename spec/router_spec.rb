# frozen_string_literal: true

RSpec.describe Porous::Router do
  it "builds a route map" do
    router = Porous::Router.new
    expect(router.routes).to be_a Hash
  end

  it "builds a route map from classes" do
    class Home < Porous::Page; end
    router = Porous::Router.new [Home]
    expect(router.routes.keys).to eq ['']
    expect(router.routes.values).to eq [Home]
  end

  it "finds a Page from a route with only static segments" do
    class About < Porous::Page
      def self.route; ['about']; end
    end

    class Contact < Porous::Page
      def self.route; ['contact']; end
    end

    router = Porous::Router.new [About, Contact]
    expect(router.routes.keys).to eq ['about', 'contact']
    expect(router.routes.values).to eq [About, Contact]

    expect(router.lookup('/contact')).to eq Contact
  end
end
