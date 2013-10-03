Gem::Specification.new do |s|
  s.name        = "hilbert"
  s.version     = "0.0.2"
  s.authors     = "Jim Kingdon"
  s.email       = "kingdon@panix.com"
  s.homepage    = "http://github.com/jkingdon/hilbert"
  s.summary     = "Hilbert theorem prover"
  s.description = "Write mathematical proofs and script them in Ruby"

#  s.rubyforge_project = s.name

  s.add_dependency 'treetop'

  s.add_development_dependency "rspec",   "~> 2.14.0"

  s.files = `git ls-files`.split("\n")
  s.require_path = "lib"
end
