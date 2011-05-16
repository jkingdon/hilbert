require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

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

  it "can set ancillary data" do
    pending("this API is annoying from FFI; lots of memory allocation")
    proof = Hilbert.hilbert_module_create(:proof)

    FFI::MemoryPointer.new(:int, 1) do |ancillary|
      Hilbert.hilbert_module_setancillary(proof, ancillary, 0).
        should == 0
      Hilbert.hilbert_module_getancillary(proof).should == ancillary
    end
  end

  it "hilbert_kind_alias"
  it "hilbert_kind_identify"
  it "hilbert_kind_isequivalent"
  it "hilbert_kind_equivalenceclass"
  it "hilbert_module_param"
  it "hilbert_module_import"
  it "hilbert_module_export"

  it "with an empty proof module has no objects" do
    proof = Hilbert.hilbert_module_create(:proof)
    FFI::MemoryPointer.new(:int, 1) do |errcodep|
      FFI::MemoryPointer.new(:size_t, 1) do |countp|
        objects = Hilbert.hilbert_module_getobjects(
          proof, countp, errcodep
        )
        errcodep.get_int(0).should == Hilbert::SUCCESS
        Hilbert.get_size_t(countp, 0).should == 0
        Hilbert.hilbert_array_free(objects)
      end
    end
  end
end

