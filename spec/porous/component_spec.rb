# frozen_string_literal: true

RSpec.describe Porous::Component do
  describe 'render pipeline' do
    let! :button_class do
      Class.new(described_class) do
        def content
          button do
            em 'Click me!'
          end
        end
      end
    end

    let :card_class do
      Class.new(described_class) do
        def content
          div class: 'card' do
            h1 'Title'
            hr
            component Class.new(Porous::Component) { def content = button }
          end
        end
      end
    end

    let :link_class do
      Class.new(described_class) do
        def where = 'Parent'

        def content
          component(Class.new(Porous::Component) do
            def where = 'Child'

            def content
              a do
                if block_given?
                  yield
                else
                  text 'Default text'
                end
              end
            end
          end) do
            text "Substitute text from #{where}"
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
      expect(card.render!).to eq('<div class="card"><h1>Title</h1><hr><button></button></div>')
    end

    it 'renders content in a block inside a child component in its own context' do
      link = link_class.new
      link.evaluate!
      expect(link.render!).to eq('<a>Substitute text from Parent</a>')
    end
  end
end
