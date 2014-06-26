require 'active_support/concern'
require 'active_support/core_ext/string/output_safety'

module Tallulah
  module Context
    extend ActiveSupport::Concern

    included do
      attr_reader :children
    end

    def append_node(node)
      @children << node
      node
    end

    def to_html
      @children.map(&:to_html).join.html_safe
    end

    module ClassMethods
      def register_component(name)
        component_class = self
        Context.class_eval do
          define_method(name) do |*args, &block|
            append_node(component_class.new(self, *args, &block))
          end
        end
      end
    end
  end
end
