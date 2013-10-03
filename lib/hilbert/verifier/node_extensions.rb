module Hilbert
  class Top < Treetop::Runtime::SyntaxNode
    def to_tree
      text_value #elements.map(&:to_tree)
    end
  end

  class Token < Treetop::Runtime::SyntaxNode
    def to_tree
      elements.first.to_tree
    end
  end

  class Word < Treetop::Runtime::SyntaxNode
    def to_tree
      text_value
    end
  end

  class Whitespace < Treetop::Runtime::SyntaxNode
    def to_tree
      ''
    end
  end
end
