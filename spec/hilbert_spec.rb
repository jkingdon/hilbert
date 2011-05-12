require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe Hilbert do
  it "can create and retrieve type" do
    begin
      proof = Hilbert.hilbert_module_create(:proof)
      Hilbert.hilbert_module_gettype(proof).should == :proof
    ensure
      Hilbert.hilbert_module_free(proof) if proof
    end
  end
end

