module Tallulah
  class Text < Node
    def initialize(parent, text)
      super(parent)
      @text = text
    end

    def to_html
      @text
    end
  end
end