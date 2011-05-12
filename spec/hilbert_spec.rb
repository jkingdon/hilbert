require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe Hilbert do
  it "can create and retrieve type" do
    proof = Hilbert.hilbert_module_create(:proof)
    Hilbert.hilbert_module_gettype(proof).should == :proof
  end

  it "can free a module" do
    # For most of these tests, we are content to leak memory.
    # Here we just check that free doesn't blow up.
    proof = Hilbert.hilbert_module_create(:proof)
    Hilbert.hilbert_module_free(proof)
  end

  it "can mark an interface as immutable" do
    interface = Hilbert.hilbert_module_create(:interface)
    Hilbert.hilbert_module_makeimmutable(interface).should ==
      Hilbert::SUCCESS
  end

  it "cannot mark a proof module as immutable" do
    proof = Hilbert.hilbert_module_create(:proof)
    Hilbert.hilbert_module_makeimmutable(proof).should ==
      Hilbert::INVALID_MODULE
  end

  it "get an error if the module is already immutable" do
    interface = Hilbert.hilbert_module_create(:interface)
    Hilbert.hilbert_module_makeimmutable(interface)
    Hilbert.hilbert_module_makeimmutable(interface).should ==
      Hilbert::IMMUTABLE
  end

  it "can tell me a mutable interface is not immutable" do
    interface = Hilbert.hilbert_module_create(:interface)

    FFI::MemoryPointer.new(:int, 1) do |errcodep|
      Hilbert.hilbert_module_isimmutable(interface, errcodep).
        should == 0
      errcodep.get_int(0).should == Hilbert::SUCCESS
    end
  end

  it "can tell me an immutable module is immutable" do
    interface = Hilbert.hilbert_module_create(:interface)
    Hilbert.hilbert_module_makeimmutable(interface)

    FFI::MemoryPointer.new(:int, 1) do |errcodep|
      Hilbert.hilbert_module_isimmutable(interface, errcodep).
        should == 1
      errcodep.get_int(0).should == Hilbert::SUCCESS
    end
  end

  it "says that proof modules are not immutable" do
    proof = Hilbert.hilbert_module_create(:proof)

    FFI::MemoryPointer.new(:int, 1) do |errcodep|
      Hilbert.hilbert_module_isimmutable(proof, errcodep).
        should == 0
      errcodep.get_int(0).should == Hilbert::SUCCESS
    end
  end
end

