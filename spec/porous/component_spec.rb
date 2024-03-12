# frozen_string_literal: true

RSpec.describe Porous::Component do
  describe 'render pipeline' do
    class self::Button < Porous::Component
      def content
        button
      end
    end

    let(:button_class) do
      self.class::Button
    end

    it 'creates a render context if one is not provided' do
      component = described_class.new
      render_context = component.instance_eval { @context }
      expect(render_context).to be_a(Porous::RenderContext)
    end

    it 'can be rendered' do
      button = button_class.new
      button.evaluate!
      expect(button.render!).to eq('<button></button>')
    end
  end
end
