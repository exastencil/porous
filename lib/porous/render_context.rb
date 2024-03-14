# frozen_string_literal: true

module Porous
  class RenderContext
    attr_reader :root, :buffer

    def initialize(root)
      @buffer = []
      @root = root
    end

    # Render in the server context simply means to concatenate the HTML
    # in the buffer of the render context.
    #
    def render
      @buffer.join
    end

    def clear
      @buffer = []
    end

    def tag(symbol, attrs = {}, content = nil, self_closing: false, foreign: false)
      attributes = process_attributes(attrs).map { |k, v| " #{k}=\"#{v}\"" }.join
      tag_name = foreign ? symbol : camel_case_lower(symbol)
      @buffer << "<#{tag_name}#{attributes}#{" /" if self_closing && foreign}>"
      if block_given?
        yield
      elsif content
        text content
      end
      @buffer << "</#{tag_name}>" unless self_closing
    end

    def text(string)
      @buffer << string
    end

    private

    # This method allows one to pass a nested hash with symbol keys that
    # will be flattened into a suitable format for HTML attributes.
    #
    # @param hash [Hash] A nested hash to be flattened.
    # @return [Hash] A flattened hash with suitable key names.
    def process_attributes(hash)
      hash.each_with_object({}) do |(key, value), result|
        new_key = key.to_s.tr '_', '-'
        if value.is_a? Hash
          process_attributes(value).each do |sub_key, sub_value|
            result["#{new_key}-#{sub_key}"] = sub_value
          end
        else
          result[new_key] = value
        end
      end
    end

    def camel_case_lower(symbol)
      symbol.to_s.split('_').inject([]) { |buffer, e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
    end
  end
end
