require '../jhilbert/target/jhilbert-9.jar'

module Hilbert
  module JHilbert
    def self.process_file(filename)
      Java::JHilbert::Main.main("--wiki", filename)
    end
  end
end

