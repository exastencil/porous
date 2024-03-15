# frozen_string_literal: true

module Porous
  class Component
    def initialize(props: {}, context: nil)
      @context = context || RenderContext.new(self)
      props.select { |key, _| self.class.properties.include?(key.to_sym) }.each do |prop, value|
        instance_variable_set("@#{prop}", value)
      end
    end

    def content = nil

    def evaluate!(&block)
      @context.clear if @context.root == self
      content(&block)
    end

    def render!
      @context.render
    end

    def self.property(prop)
      @properties ||= []
      @properties << prop
    end

    def self.properties
      @properties || []
    end

    protected

    def component(component_class_or_instance, **props, &block)
      component_instance = if component_class_or_instance.is_a?(Class)
                             component_class_or_instance.new(props: props, context: @context)
                           else
                             component_class_or_instance
                           end
      component_instance.evaluate!(&block)
    end

    # Content-based closing tags: e.g. <tag>content</tag>
    %i[a abbr address article aside audio b bdi bdo blockquote body button
       canvas caption cite code colgroup data datalist dd del details dfn dialog div dl dt
       em fencedframe fieldset figcaption figure footer form
       h1 h2 h3 h4 h5 h6 head header hgroup html i iframe ins
       kbd label legend li main map mark menu meter nav noscript
       object ol optgroup option output p picture portal pre progress q rp rt ruby
       s samp script search section select slot small span strong style sub summary sup
       table tbody td template textarea tfoot th thead time title tr u ul var video].each do |tag|
      define_method(tag) do |text = nil, **attrs, &block|
        @context.tag(tag, attrs, text, &block)
      end
    end

    # Void tags tags e.g. <hr>
    %i[area base br col embed hr img input link meta source track wbr].each do |tag|
      define_method(tag) do |**attrs|
        @context.tag(tag, attrs, self_closing: true)
      end
    end

    # Container foreign tags: e.g <svg></svg> that follows XML tag name conventions
    %i[animate_motion svg clip_path fe_func_a fe_func_b fe_func_g fe_func_r
       fe_gaussian_blur filter linear_gradient marker mask pattern radial_gradient
       symbol text text_path tspan defs desc fe_component_transfer fe_drop_shadow
       fe_merge fe_specular_lighting
       foreign_object g metadata mpath switch use].each do |tag|
      define_method(tag) do |text = nil, **attrs, &block|
        @context.tag(tag, attrs, text, self_closing: false, foreign: true, &block)
      end
    end

    # Self-closing foreign tags i.e. in an XML context (SVG, MathML, etc)
    %i[animate animate_transform circle ellipse fe_blend fe_color_matrix
       fe_composite fe_convolve_matrix fe_displacement_map fe_image
       fe_turbulence image line path set view fe_diffuse_lighting fe_distant_light fe_merge_node fe_morphology
       fe_offset fe_point_light fe_spot_light fe_tile polygon polyline
       rect stop].each do |tag|
      define_method(tag) do |**attrs|
        @context.tag(tag, attrs, self_closing: true, foreign: true)
      end
    end

    # Bare text node
    def text(string)
      @context.text(string)
    end
  end
end
