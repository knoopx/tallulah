require 'active_support/core_ext/string/output_safety'

module Tallulah
  class Tag < Node
    autoload :Attributes, "tallulah/tag/attributes"

    attr_reader :name, :attributes

    def initialize(parent, name, attrs = default_attributes)
      super(parent)
      @name, @attributes = name, Attributes.new(attrs)
    end

    def default_attributes
      {}
    end

    def [](key)
      @attributes[key]
    end

    def to_html
      "<#{@name}#{@attributes}/>".html_safe
    end
  end
end
