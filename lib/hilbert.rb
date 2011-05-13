require 'rubygems'
require 'ffi'

module Hilbert
  extend FFI::Library
  ffi_lib '../hilbert-kernel/src/.libs/libhilbert.so'
  ModuleType = enum [:interface, :proof]

  # Not sure why an enum didn't work. Because the values are negative?
  SUCCESS = 0
  NOMEM = -1
  IMMUTABLE = -2
  INVALID_MODULE = -3
  INVALID_HANDLE = -4
  COUNT_MISMATCH = -5
  INVALID_MAPPING = -6
  MAPPING_CLASH = -7
  NO_EQUIVALENCE = -8
  INTERNAL = -99

  attach_function :hilbert_module_create, [ ModuleType ], :pointer
  attach_function :hilbert_module_free, [ :pointer ], :void
  attach_function :hilbert_module_gettype, [ :pointer ], ModuleType
  attach_function :hilbert_module_makeimmutable, [ :pointer ], :int 
  attach_function :hilbert_module_isimmutable,
    [ :pointer, :pointer ], :int
  attach_function :hilbert_module_getobjects,
    [ :pointer, :pointer, :pointer ], :pointer
  attach_function :hilbert_array_free, [ :pointer ], :void
end

