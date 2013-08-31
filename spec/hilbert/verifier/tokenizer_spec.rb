require_relative '../../spec_helper'
require_relative '../../../lib/hilbert.rb'

describe "Tokenizer" do
  let(:tokenizer) { Tokenizer.new(StringIO.new(input)) }
  let(:input) { "foo" }

  it "can tokenize something simple" do
    expect(tokenizer.next_token).to eq("foo")
    expect(tokenizer.next_token).to eq(nil)
  end
end

