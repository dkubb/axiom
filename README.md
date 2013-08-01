axiom
=====

Simplifies querying of structured data using relational algebra.

[![Gem Version](https://badge.fury.io/rb/axiom.png)][gem]
[![Build Status](https://secure.travis-ci.org/dkubb/axiom.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dkubb/axiom.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dkubb/axiom.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/dkubb/axiom/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/axiom
[travis]: https://travis-ci.org/dkubb/axiom
[gemnasium]: https://gemnasium.com/dkubb/axiom
[codeclimate]: https://codeclimate.com/github/dkubb/axiom
[coveralls]: https://coveralls.io/r/dkubb/axiom

Examples
--------

```ruby
relation = Axiom::Relation.new(
  [[:id, String], [:name, String], [:color, String], [:weight, Float], [:city, String]],
  [
    ['P1', 'Nut',   'Red',   12.0, 'London'],
    ['P2', 'Bolt',  'Green', 17.0, 'Paris' ],
    ['P3', 'Screw', 'Blue',  17.0, 'Oslo'  ],
    ['P4', 'Screw', 'Red',   14.0, 'London'],
    ['P5', 'Cam',   'Blue',  12.0, 'Paris' ],
    ['P6', 'Cog',   'Red',   19.0, 'London'],
 ]
)

# Relational Operators
# --------------------

# projection
new_relation = relation.project([:id])

# removal
new_relation = relation.remove([:name])

# rename
new_relation = relation.rename(id: :other_id, name: :other_name)

# restriction
new_relation = relation.restrict { |r| r.name.eq('Screw').or(r.city.eq('London')) }
new_relation = relation.restrict(relation.name.eq('Screw'))
new_relation = relation.restrict(name: 'Screw')
new_relation = relation.restrict([[:name, 'Screw']])

# natural join
new_relation = relation.join(other)        # OR relation + other

# product
new_relation = relation.product(other)     # OR relation * other

# intersection
new_relation = relation.intersect(other)   # OR relation & other

# union
new_relation = relation.union(other)       # OR relation | other

# difference
new_relation = relation.difference(other)  # OR relation - other

# theta-join
new_relation = relation.join(other) { |r| r.id.gte(r.other_id) }

# NOTE: theta-join is effectively restricting a product of the relations

# extend
new_relation = relation.extend { |r| r.add(:pounds, r.weight * 2.2) }
new_relation = relation.extend { |r| r.add(:pounds) { |t| t[:weight] * 2.2 } }

# summarize
new_relation = relation.summarize(relation.project([:city])) { |r| r.add(:count, r.id.count) }
new_relation = relation.summarize(relation.project([:city])) { |r| r.add(:count) { |acc, t| acc.to_i + 1 } }

# Non-Relational Operators
# ------------------------

# returns a set that represents the relation header
header = relation.header

# a relation is Enumerable
relation = relation.each { |tuple| ... }

# order by attributes in the header
ordered = relation.sort

# order by attribute and direction
ordered = relation.sort_by { |r| [r.city.desc, r.name, r.color, r.id, r.weight] }

# reverse the relation (only allowed if ordered)
new_relation = ordered.reverse

# offset (only allowed if ordered)
new_relation = ordered.drop(5)

# limiting (only allowed if ordered)
new_relation = ordered.take(10)

# get the first n tuples (only allowed if ordered)
new_relation = ordered.first     # default is 1
new_relation = ordered.first(5)

# get the last n tuples (only allowed if ordered)
new_relation = ordered.last      # default is 1
new_relation = ordered.last(5)

# get a tuple from a relation containing exactly one tuple
tuple = relation.one

# Updatable Views
# ---------------

# add a set to a relation variable
new_relation = relation.insert(other)

# remove a set from a relation variable
new_relation = relation.delete(other)

# replace a relation variable with another set
new_relation = relation.replace(other)

# each subset of unique keys as header objects
keys = header.keys
```

Goals
-----

The purpose of this project is to expand my knowledge of relational algebra by attempting to implement a simple query system using the primitive operations defined in relational algebra.

Most of the design is heavily inspired from [koios](https://github.com/carllerche/koios) and [arel](https://github.com/rails/arel). The reason I decided to write my own and not just build on top of those systems was not so much because I don't like the code/API in those projects, it's more because I wanted to gain a depth of understanding that can only be earned by trying to solve the problem myself.

I should note though that I don't plan to just re-implement those systems with a different API, or different internals, I plan to make something that surpasses them in several areas. For example, I want to be able to join information from multiple datastores and represent it as a single relation. I want to be able to insert, update or delete from that relation and have those changes propagated back to the right datastore. This is not an easy feat, since it is basically the updatable view problem that RDBMS' struggle with. While I do think there are some cases where relations will become read-only, I think it will be possible to propagate writes properly in this manner. I certainly think for the current use cases in DataMapper this should work quite well.

The ability to join data from multiple datastores and have it presented in a consistent manner will solve one of the longest standing problems in DataMapper, namely how do we do cross repository joins. It should be possible to construct one query for one datastore, and then another query for another datastore and then join them. Since they are using different engines Axiom will know to perform each query *natively* and then join the results in-memory seamlessly. It should also be possible to reorganize the queries so that as much work as possible is done natively as opposed to in-memory, which is considered the last resort.

Not only does this work nicely with associations, but it will allow DataMapper to perform mapping in a more powerful way. You'll be able to construct a join from multiple datastores, and set that as the base for your model. Each DM Resource would work as normal, but again writes could be propagated back to the appropriate datastore. You'd be able to split your data up between different datastores, but assemble it into one coherent view.

Related Projects
----------------

* [axiom-optimizer](https://github.com/dkubb/axiom-optimizer)

This is an optimizer that takes a Axiom relation, scalar or aggregate function and will transform it into something equivalent but simpler in structure to the original.

* [axiom-sql-generator](https://github.com/dkubb/axiom-sql-generator)

This is a visitor class that takes a Axiom relation and generates valid SQL from it.

* [axiom-do-adapter](https://github.com/dkubb/axiom-do-adapter)

This is a system that manages the database connections and executes the SQL generated from the relations.

Contributing
------------

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

Copyright
---------

Copyright &copy; 2009-2013 Dan Kubb. See LICENSE for details.
