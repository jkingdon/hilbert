require 'rubygems'
require 'ffi'

module Hilbert
  extend FFI::Library
  ffi_lib '../hilbert-kernel/src/.libs/libhilbert.so'
  ModuleType = enum :module_type, [:interface, :proof]
  attach_function :hilbert_module_create, [ ModuleType ], :pointer
  attach_function :hilbert_module_free, [ :pointer ], :void
  attach_function :hilbert_module_gettype, [ :pointer ], ModuleType
  attach_function :hilbert_module_makeimmutable, [ :pointer ], :int
end

