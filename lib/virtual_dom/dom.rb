# frozen_string_literal: true

module VirtualDOM
  module DOM
    HTML_TAGS = %w[a abbr address area article aside audio b base bdi bdo big blockquote body br
                   button canvas caption cite code col colgroup data datalist dd del details dfn
                   dialog div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5
                   h6 head header hr html i iframe img input ins kbd keygen label legend li link
                   main map mark menu menuitem meta meter nav noscript object ol optgroup option
                   output p param picture pre progress q rp rt ruby s samp script section select
                   small source span strong style sub summary sup table tbody td textarea tfoot th
                   thead time title tr track u ul var video wbr].freeze

    SVG_TAGS = %w[svg path].freeze

    (HTML_TAGS + SVG_TAGS).each do |tag|
      define_method tag do |params = {}, &block|
        if params.is_a?(String)
          process_tag(tag, {}, block, params)
        elsif params.is_a?(Hash)
          process_tag(tag, params, block)
        end
      end
    end

    def process_tag(tag, params, block, children = [])
      @__virtual_nodes__ ||= []
      if block
        current = @__virtual_nodes__
        @__virtual_nodes__ = []
        result = block.call || children
        vnode = VirtualNode.new(tag, process_params(params),
                                @__virtual_nodes__.count.zero? ? result : @__virtual_nodes__)
        @__virtual_nodes__ = current
      else
        vnode = VirtualNode.new(tag, process_params(params), children)
      end
      @__last_virtual_node__ = vnode
      @__virtual_nodes__ << @__last_virtual_node__
      self
    end

    # rubocop:disable Style/MissingRespondToMissing, Metrics/MethodLength, Metrics/AbcSize
    def method_missing(klass, params = {}, &block)
      return unless @__last_virtual_node__
      return unless @__virtual_nodes__

      @__virtual_nodes__.pop
      children = []

      if params.is_a?(String)
        children = [params]
        params = {}
      end

      class_params = @__last_virtual_node__.params.delete(:className)
      method_params = if klass.end_with?('!')
                        { id: clazz[0..-2],
                          class: merge_string(class_params, params[:class]) }
                      else
                        { class: merge_string(class_params, params[:class], klass.gsub('_', '-').gsub('--', '_')) }
                      end
      params = @__last_virtual_node__.params.merge(params).merge(method_params)
      process_tag(@__last_virtual_node__.name, params, block, children)
    end
    # rubocop:enable Style/MissingRespondToMissing, Metrics/MethodLength, Metrics/AbcSize

    def merge_string(*params)
      arr = []
      params.each do |string|
        next unless string

        arr << string.split
      end
      arr.join(' ')
    end

    def process_params(params)
      params.dup.each_key do |k|
        case k
        when 'for'
          params['htmlFor'] = params.delete('for')
        when 'class'
          params['className'] = params.delete('class')
        when 'data'
          params['dataset'] = params.delete('data')
        when 'default'
          params['defaultValue'] = params.delete('default')
        when /^on/
          # Events are ignored server-side
          params.delete k
        end
      end
      params
    end

    def text(string)
      @__virtual_nodes__ << string.to_s
    end

    def to_vnode
      if @__virtual_nodes__.one?
        @__virtual_nodes__.first
      else
        VirtualNode.new('div', {}, @__virtual_nodes__)
      end
    end

    def class_names(hash)
      class_names = []
      hash.each do |key, value|
        class_names << key if value
      end
      class_names.join(' ')
    end
  end
end
