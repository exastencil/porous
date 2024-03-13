# frozen_string_literal: true

RSpec.describe Porous::Component do
  describe 'render pipeline' do
    let(:button_class) do
      Class.new(described_class) do
        def content
          button do
            em do
              text 'Click me!'
            end
          end
        end
      end
    end

    let :card_class do
      Class.new(described_class) do
        def content
          div class: 'card' do
            h1 'Title'
            p 'Content'
          end
        end
      end
    end

    it 'creates a render context if one is not provided' do
      component = described_class.new
      render_context = component.instance_eval { @context }
      expect(render_context).to be_a(Porous::RenderContext)
    end

    it 'renders nested tags' do
      button = button_class.new
      button.evaluate!
      expect(button.render!).to eq('<button><em>Click me!</em></button>')
    end

    it 'renders a child component' do
      card = card_class.new
      card.evaluate!
      expect(card.render!).to eq('<div class="card"><h1>Title</h1><p>Content</p></div>')
    end
  end
end
