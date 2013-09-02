class Token
  attr_reader :line, :start_column, :end_column, :text

  def initialize(line, start_column)
    @line = line
    @start_column = start_column
    @end_column = start_column
    @text = ""
  end

  def add_character(character)
    @end_column += 1
    @text += character
  end
end

class EndOfFile
  attr_reader :line

  def initialize(line, column)
    @line = line
    @column = column
  end

  def start_column
    @column
  end

  def end_column
    @column
  end

  def text
    nil
  end
end

class Tokenizer
  def initialize(stream)
    @stream = stream
    @line = 1
    @column = 1
    @token = nil
  end

  def read
    while true
      if @stream.eof?
        # TODO: why this and the nil case both?
        @token ||= EndOfFile.new(@line, @column)
        return
      end

      character = @stream.readchar
      case character
        when ' ', "\t", "\n"
          # do nothing
        when nil
          @token ||= EndOfFile.new(@line, @column)
        else
          @token ||= Token.new(@line, @column)
          @token.add_character(character)
      end
      @column += 1
    end
  end

  def next_token
    @token = nil
    read
    @token.text
  end

  def current_line
    1
  end

  def current_column_start
    @token.start_column
  end

  def current_column_end
    @token.end_column
  end

end

