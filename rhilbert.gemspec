Gem::Specification.new do |s|
  s.name        = "rhilbert"
  s.version     = "0.0.1"
  s.authors     = "Jim Kingdon"
  s.email       = "kingdon@panix.com"
  s.homepage    = "http://github.com/jkingdon/rhilbert"
  s.summary     = "Rhilbert theorem prover"
  s.description = "Write mathematical proofs and script them in Ruby"

#  s.rubyforge_project = s.name

  s.add_dependency "ffi", ">= 1.0.7"

  s.add_development_dependency "rspec",   "~> 2.5.0"

#  s.files = `git ls-files`.split("\n")
  s.require_path = "lib"
end
