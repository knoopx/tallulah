module Tallulah
  class Node
    attr_reader :parent

    def initialize(parent)
      @parent = parent
    end
  end
end