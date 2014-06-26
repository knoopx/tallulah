module Tallulah
  class Component < Node
    include Context

    def initialize(parent, &block)
      super(parent)
      @children = []
      instance_eval(&block) if block
    end
  end
end
