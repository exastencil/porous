# frozen_string_literal: true

RSpec.describe Porous::Page do
  let :sample_page do
    Class.new(described_class) do
      metadata route: '/sample/:type', title: 'Sample Page', description: 'Just an empty page'
      def content = body
    end
  end

  describe 'metadata' do
    it 'can be used to set the page title' do
      page = sample_page.new
      page.evaluate!
      expect(page.render!).to include('<title>Sample Page</title>')
    end

    it 'can be used to set the page description' do
      page = sample_page.new
      page.evaluate!
      expect(page.render!).to include('<meta name="description" content="Just an empty page">')
    end

    it 'can be used to set the page route' do
      expect(sample_page.page_metadata[:route]).to eq '/sample/:type'
    end
  end

  describe 'params' do
    it 'can be initialised' do
      page = sample_page.new params: { type: 'biological' }
      expect(page.instance_variable_get(:@params)).to eq({ type: 'biological' })
    end

    it 'are automatically set as instance variables' do
      page = sample_page.new params: { type: 'biological' }
      expect(page.instance_variables).to include(:@type)
    end
  end
end
