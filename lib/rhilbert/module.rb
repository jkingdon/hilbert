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

    ERROR_MESSAGES = {
      RHilbert::Hilbert::NOMEM => "Out of memory",
      RHilbert::Hilbert::IMMUTABLE =>
        "Must be immutable but isn't or vice versa",
      RHilbert::Hilbert::INVALID_MODULE =>
        "Must be proof module but is interface module or vice versa",
      RHilbert::Hilbert::INVALID_HANDLE =>
        "Bad object handle or wrong object type",
      RHilbert::Hilbert::COUNT_MISMATCH =>
        "Bad object count",
      RHilbert::Hilbert::INVALID_MAPPING =>
        "Error with object handle",
      RHilbert::Hilbert::MAPPING_CLASH =>
        "Map is not one to one",
      RHilbert::Hilbert::NO_EQUIVALENCE =>
        "Map does not respect kind equivalence classes",
      RHilbert::Hilbert::INTERNAL =>
        "Hilbert kernel internal error"
    }

    def check_error(errcode, overrides = {})
      messages = ERROR_MESSAGES.merge(overrides)
      if errcode == RHilbert::Hilbert::SUCCESS
        true
      elsif messages[errcode]
        raise messages[errcode]
      else
        raise "Hilbert kernel failed with code #{errcode}"
      end
    end

    public
    def immutable?
      is_immutable = nil
      FFI::MemoryPointer.new(:int, 1) do |errcodep|
        is_immutable =
          RHilbert::Hilbert.hilbert_module_isimmutable(
            hilbert_module, errcodep) != 0
        check_error(errcodep.get_int(0))
      end
      is_immutable
    end

    def set_immutable
      errcode = RHilbert::Hilbert.hilbert_module_makeimmutable(hilbert_module)
      check_error(errcode, RHilbert::Hilbert::INVALID_MODULE =>
        "Cannot mark a proof module as immutable")
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
