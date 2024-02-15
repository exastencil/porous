module VirtualDOM
  class VirtualNode
    attr_reader :name, :params, :children

    def initialize(name, params = {}, children = [])
      @name = name
      @params = params
      @children = children
    end

    def to_s
      "<#{@name}#{to_s_params}>#{to_s_children}</#{@name}>"
    end

    def to_s_params
      return unless @params.any?

      ' ' + @params.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
    end

    def to_s_children
      return @children if @children.is_a?(String)
      return unless @children.any?

      @children
        .map(&:to_s)
        .join
    end
  end
end
