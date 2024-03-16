# frozen_string_literal: true

RSpec.describe Porous::Router do
  let! :sample_page do
    Class.new(Porous::Page) do
      metadata route: '/sample', title: 'Sample Page'
      def content = body(class: 'sample-page')
    end
  end

  let! :example_page do
    Class.new(Porous::Page) do
      metadata route: '/example', title: 'Example Page'
      def content = body(class: 'example-page')
    end
  end

  let! :blog_page do
    Class.new(Porous::Page) do
      metadata route: '/blog/:page', title: 'Blog Page'
      def content = body("Page #{@page}", class: 'blog-page')
    end
  end

  it 'is a singleton class' do
    expect(described_class.instance).to eq described_class.instance
  end

  it 'determines which page to render by their routes' do
    page = described_class.find_by_path '/sample'
    expect(page).to be sample_page

    page = described_class.find_by_path '/example'
    expect(page).to be example_page
  end

  it 'can create a page instance with params populated' do
    page = described_class.create_from_path '/blog/1'
    expect(page).to be_a blog_page
    expect(page.instance_eval { @params }).to eq({ page: '1' })
  end
end
