require_relative '../../spec_helper'
require_relative '../../../lib/hilbert.rb'

describe "Tokenizer" do
  let(:tokenizer) { Tokenizer.new(StringIO.new(input)) }
  let(:input) { "foo" }

  it "can tokenize something simple" do
    expect(tokenizer.next_token).to eq("foo")
    expect(tokenizer.next_token).to eq(nil)
  end

  context "with a bunch of extraneous whitespace" do
    let(:input) { "  \tfoo\n\n   \n" }

    it "ignores all the whitespace" do
      expect(tokenizer.next_token).to eq("foo")
      expect(tokenizer.next_token).to eq(nil)
    end
  end

  context "with two tokens" do
    let(:input) { "foo bar" }
    it "returns them" do
      expect(tokenizer.next_token).to eq("foo")
      expect(tokenizer.next_token).to eq("bar")
      expect(tokenizer.next_token).to eq(nil)
    end

    it "gives line/column numbers for each"
  end

  context "with a parenthesized expression"

  context "with some leading and trailing whitespace" do
    let(:input) { "  pi  " }
    it "can give line and column numbers" do
      expect(tokenizer.next_token).to eq("pi")
      expect(tokenizer.current_line).to eq(1)
      expect(tokenizer.current_column_start).to eq(3)
      expect(tokenizer.current_column_end).to eq(5)
    end

    it "gives the correct position of the end of the file" do
      tokenizer.next_token
      expect(tokenizer.next_token).to eq(nil)
      expect(tokenizer.current_line).to eq(1)
      expect(tokenizer.current_column_start).to eq(7)
      expect(tokenizer.current_column_end).to eq(7)
    end
  end

  context "with several lines" do
    it "can give line and column numbers"
  end

  context "with multibyte characters" do
    it "returns column numbers in characters, not bytes"
  end

  context "with mismatched parentheses" do
    it "gives an error"
    it "includes the line/column number of the unclosed parenthesis"
  end

  context "with comments" do
    it "ignores to end of line"
    it "does not ignore subsequent lines"
    it "does not ignore the line prior to the comment start"
    it "does not try to make parentheses be balanced within a comment"
  end
end

