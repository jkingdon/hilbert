class Tokenizer
  def initialize(stream)
    @stream = stream
  end

  def next_token
    result = @stream.read
    if @stream.eof? && result == ""
      nil
    else
      result.strip
    end
  end

end

