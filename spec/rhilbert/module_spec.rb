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

  it "proof module is a proof and not an interface module" do
    RHilbert::Module.proof do |m|
      m.should_not be_interface
      m.should be_proof
    end
  end

  it "is not immutable by default" do
    RHilbert::Module.interface do |m|
      m.should_not be_immutable
    end
  end

  it "can mark an interface as immutable" do
    RHilbert::Module.interface do |m|
      m.set_immutable
      m.should be_immutable
    end
  end

  it "cannot mark a proof module as immutable" do
    RHilbert::Module.proof do |m|
      lambda { m.set_immutable }.should raise_error(
        "Cannot mark a proof module as immutable"
      )
      m.should_not be_immutable
    end
  end

  it "get an error if the module is already immutable" do
    RHilbert::Module.interface do |m|
      m.set_immutable
      lambda { m.set_immutable }.should raise_error(
        "Module is already immutable"
      )
      m.should be_immutable
    end
  end

  it "says that proof modules are not immutable" do
    RHilbert::Module.proof do |m|
      m.should_not be_immutable
    end
  end

  it "with an empty proof module has no objects"
end

