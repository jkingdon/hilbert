The Hilbert gem contains ruby bindings to formalized math. The current idea is to
reimplement a ghilbert verifier in ruby (and in better objected-oriented style than
the Python/Javascript ghilbert verifiers as of 2013).

Ghilbert
--------
See [ghilbert](https://code.google.com/p/ghilbert/). The ghilbert verifier here should be considered incomplete.

The vision of scriptable proofs
-------------------------------

Most formalized math proof systems (measured by number of theorems proved) contain a prover (which is able to discover proofs, often given tactics which usually give the prover a range of options, rather than an exact algorithm for proving a given result). Examples of systems of this sort are Coq and Isabelle.

Metamath is the most successful system which eschews this approach. It is an interesting exercise to see how much a metamath-style system can get by using only convenience theorems to eliminate repetitive proofs, but it remains to be seen whether the tedium level can really be decreased enough using this approach.

The Hilbert gem is a stab at another approach: rather than a prover, simply embed a conventional scripting language (in this case Ruby). Well, of course Ruby is powerful enough to code a prover and I'm not ruling out such a thing, but I'm thinking more in terms of helpers which take a more mechanical approach: "move all quantifiers embedded within the consequent to the start of the consequent, applying distinct variable constraints as needed" or "given a conjunction of disjunctions, split them out into a disjunction of conjunctions".

This repository, for now, does not include any implementation of this concept.

Usage
-----

Nothing usable yet.

Status
------

Very preliminary. Embryonic, really, as of August 20132.

