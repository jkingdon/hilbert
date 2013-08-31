require '../jhilbert/target/jhilbert-9.jar'

module Hilbert
  module JHilbert
    class ProofModule
      def initialize
        @storage = Java::JHilbert::storage::wiki::Storage.new
      end

      def import(filename)
        @storage.retrieveModule(filename, -1)
      end
    end

    def self.process_file(filename)
      Java::JHilbert::Main.main("--wiki", filename)
    end

    def self.new_proof_module
      ProofModule.new
    end
  end
end

