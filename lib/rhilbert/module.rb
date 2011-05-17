module RHilbert
  class Module
    def self.create
      mmodule = new
      yield(mmodule)
      mmodule.free
    end

    private_class_method :new

    private
    def initialize
      @hilbert_module = Hilbert.hilbert_module_create(:proof)
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
  end
end
