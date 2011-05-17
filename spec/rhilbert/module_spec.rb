require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe RHilbert::Module do
  it "frees when it goes out of scope" do
    pending("Still haven't figured out the ManagedStruct stuff")
    begin
      RHilbert::Module.new
    end
    RHilbert::Hilbert.should_receive(:hilbert_module_free)
  end

  it "can mark an interface as immutable"

  it "cannot mark a proof module as immutable"

  it "get an error if the module is already immutable"

  it "can tell me a mutable interface is not immutable"

  it "can tell me an immutable module is immutable"

  it "says that proof modules are not immutable"

  it "with an empty proof module has no objects"
end

