require 'active_support/concern'
require 'active_support/core_ext/string/output_safety'

module Tallulah
  module Context
    extend ActiveSupport::Concern

    included do
      include Tallulah::HTML

      attr_reader :children, :current_node
    end

    def append_node(node)
      @current_node.children << node
      node
    end

    def within_node(node)
      previous_node = @current_node
      @current_node = node
      yield
    ensure
      @current_node = previous_node
    end

    def with_tallulah
      _children = @children
      _current_node = @current_node
      @children = []
      @current_node = self
      yield
      to_html
    ensure
      @children = _children
      @current_node = _current_node
    end

    def to_html
      @children.map(&:to_html).join.html_safe
    end
  end
end