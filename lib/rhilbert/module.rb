class RHilbert::Module < FFI::ManagedStruct
  def self.release(mmodule)
    RHilbert::Hilbert.hilbert_module_free(mmodule)
  end
end

