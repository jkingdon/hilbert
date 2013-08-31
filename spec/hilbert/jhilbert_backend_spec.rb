require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe "able to talk to JHilbert" do
  it "can process a file given a filename" do
    lambda do
      Hilbert::JHilbert.process_file("./Main/S/u/c/Successful")
    end.should_not raise_error
  end

  it "blows up if the file does not exist" do
    lambda do
      Hilbert::JHilbert.process_file("./Main/N/o/S/NoSuchFile")
    end.should raise_error(/FileNotFound/)
  end

  it "can import an interface" do
#    lambda do
      proof = Hilbert::JHilbert.new_proof_module
      proof.import("./Interface/S/a/m/Sample")
#    end.should_not raise_error
  end
end

