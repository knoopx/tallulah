require 'active_support/core_ext/string/output_safety'

module Tallulah
  class ContentTag < Tag
    include Context
    include HTML

    def initialize(parent, name, *args, &block)
      attrs = args.extract_options!
      super(parent, name, attrs, &nil)

      @children = []

      if block
        instance_eval(&block)
      else
        text(args.first)
      end
    end

    def to_html
      "<#{@name}#{@attributes.to_s}>#{@children.map(&:to_html).join}</#{@name}>".html_safe
    end
  end
end
