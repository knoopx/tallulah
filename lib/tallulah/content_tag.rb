require 'active_support/core_ext/string/output_safety'

module Tallulah
  class ContentTag < Tag
    attr_reader :children

    def initialize(parent, name, attrs = {})
      super(parent, name, attrs)
      @children = []
    end

    def to_html
      "<#{@name}#{@attributes.to_s}>#{@children.map(&:to_html).join}</#{@name}>".html_safe
    end
  end
end