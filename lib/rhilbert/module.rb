module RHilbert
  class Module
    def self.create(module_type, &block)
      mmodule = new(module_type)
      block.call(mmodule)
      mmodule.free
    end

    def self.interface(&block)
      create(:interface, &block)
    end

    def self.proof(&block)
      create(:proof, &block)
    end

    private_class_method :new

    private
    def initialize(module_type)
      @hilbert_module = Hilbert.hilbert_module_create(module_type)
    end

    def hilbert_module
      if @hilbert_module
        @hilbert_module
      else
        raise "Attempt to access rhilbert module outside its block"
      end
    end

    public
    def immutable?
      hilbert_module
      false
    end

    def free
      RHilbert::Hilbert.hilbert_module_free(@hilbert_module)
      @hilbert_module = nil
    end

    def interface?
      RHilbert::Hilbert.
        hilbert_module_gettype(@hilbert_module) == :interface
    end

    def proof?
      RHilbert::Hilbert.
        hilbert_module_gettype(@hilbert_module) == :proof
    end
  end
end
