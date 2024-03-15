# frozen_string_literal: true

RSpec.describe Porous::Page do
  let :sample_page do
    Class.new(described_class) do
      metadata title: 'Sample Page', description: 'Just an empty page'
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
  end
end
