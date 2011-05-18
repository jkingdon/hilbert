require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe RHilbert::Module do
  it "can allocate a module with a block" do
    RHilbert::Module.proof do |m|
      m.should_not be_nil
    end
  end

  it "frees the module when the block exits" do
    RHilbert::Hilbert.should_receive(:hilbert_module_free)
    RHilbert::Module.proof do |m|
    end
  end

  it "blows up if we let the reference escape from the block" do
    escaper = nil
    RHilbert::Module.proof do |m|
      escaper = m
    end
    lambda { escaper.immutable? }.should raise_error(
      "Attempt to access rhilbert module outside its block")
  end

  it "does not make it easy to leak memory by calling new" do
    lambda do
      RHilbert::Module.new
    end.should raise_error
  end

  it "interface module is an interface and not a proof module" do
    RHilbert::Module.interface do |m|
      m.should be_interface
      m.should_not be_proof
    end
  end

  it "is not immutable by default" do
    RHilbert::Module.proof do |m|
      m.should_not be_immutable
    end
  end

  it "can mark an interface as immutable"

  it "cannot mark a proof module as immutable"

  it "get an error if the module is already immutable"

  it "can tell me a mutable interface is not immutable"

  it "can tell me an immutable module is immutable"

  it "says that proof modules are not immutable"

  it "with an empty proof module has no objects"
end

