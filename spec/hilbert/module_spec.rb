require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

[Hilbert::HilbertKernelModule].each do |module_class|
  describe module_class do
    it "can allocate a module with a block" do
      module_class.proof do |m|
        m.should_not be_nil
      end
    end

    it "frees the module when the block exits" do
      if module_class == Hilbert::HilbertKernel
        Hilbert::HilbertKernel.should_receive(:hilbert_module_free)
        module_class.proof do |m|
        end
      end
    end

    it "blows up if we let the reference escape from the block" do
      escaper = nil
      module_class.proof do |m|
        escaper = m
      end
      lambda { escaper.immutable? }.should raise_error(
        "Attempt to access rhilbert module outside its block")
    end

    it "does not make it easy to leak memory by calling new" do
      lambda do
        module_class.new
      end.should raise_error
    end

    it "interface module is an interface and not a proof module" do
      module_class.interface do |m|
        m.should be_interface
        m.should_not be_proof
      end
    end

    it "proof module is a proof and not an interface module" do
      module_class.proof do |m|
        m.should_not be_interface
        m.should be_proof
      end
    end

    it "is not immutable by default" do
      module_class.interface do |m|
        m.should_not be_immutable
      end
    end

    it "can mark an interface as immutable" do
      module_class.interface do |m|
        m.make_immutable
        m.should be_immutable
      end
    end

    it "cannot mark a proof module as immutable" do
      module_class.proof do |m|
        lambda { m.make_immutable }.should raise_error(
          "Cannot mark a proof module as immutable"
        )
        m.should_not be_immutable
      end
    end

    it "get an error if the module is already immutable" do
      module_class.interface do |m|
        m.make_immutable
        lambda { m.make_immutable }.should raise_error(
          "Module is already immutable"
        )
        m.should be_immutable
      end
    end

    it "says that proof modules are not immutable" do
      module_class.proof do |m|
        m.should_not be_immutable
      end
    end

    it "with an empty proof module has no objects" do
      pending("not sure whether this is right, might want to be a block for memory freeing")
      module_class.proof do |m|
        m.objects.should == []
      end
    end
  end
end
