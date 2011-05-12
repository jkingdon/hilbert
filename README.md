Rhilbert is a formalized math layer (very experimental, for now) on top of hilbert-kernel.

Rationale
---------

Most formalized math proof systems (measured by number of theorems proved) contain a prover (which is able to discover proofs, often given tactics which usually give the prover a range of options, rather than an exact algorithm for proving a given result). Examples of systems of this sort are Coq and Isabelle.

Metamath is the most successful system which eschews this approach. It is an interesting exercise to see how much a metamath-style system can get by using only convenience theorems to eliminate repetitive proofs, but it remains to be seen whether the tedium level can really be decreased enough using this approach.

Rhilbert is a stab at another approach: rather than a prover, simply embed a conventional scripting language (in this case Ruby). Well, of course Ruby is powerful enough to code a prover and I'm not ruling out such a thing, but I'm thinking more in terms of helpers which take a more mechanical approach: "move all quantifiers embedded within the consequent to the start of the consequent, applying distinct variable constraints as needed" or "given a conjunction of disjunctions, split them out into a disjunction of conjunctions".

Another rationale is to make it easier to write tests for hilbert-kernel (which is the underlying proof engine for rhilbert). One can, of course, write unit tests in C (without any exception handling), but exception handling (and some of the other features of ruby and rspec) do make this easier.

Implementation
--------------

The ruby FFI library interfaces to the hilbert-kernel library (which is written in C).

Status
------

Very preliminary. Embryonic, really, as of 11 May 2011.

