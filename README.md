# Veritas

Simplifies querying of structured data using relational algebra.

[![Build Status](https://secure.travis-ci.org/dkubb/veritas.png)](http://travis-ci.org/dkubb/veritas)
[![Dependency Status](https://gemnasium.com/dkubb/veritas.png)](https://gemnasium.com/dkubb/veritas)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/dkubb/veritas)


## Installation

With Rubygems:

```bash
$ gem install veritas
$ irb -rubygems
>> require 'veritas'
=> true
```

With git and local working copy:

```bash
$ git clone git://github.com/dkubb/veritas.git
$ cd veritas
$ rake install
$ irb -rubygems
>> require 'veritas'
=> true
```

## Usage

```ruby
relation = Veritas::Relation.new(
  [ [ :id, String ], [ :name, String ], [ :color, String ], [ :weight, Float ], [ :city, String ] ],
  [
    [ 'P1', 'Nut',   'Red',   12.0, 'London' ],
    [ 'P2', 'Bolt',  'Green', 17.0, 'Paris'  ],
    [ 'P3', 'Screw', 'Blue',  17.0, 'Oslo'   ],
    [ 'P4', 'Screw', 'Red',   14.0, 'London' ],
    [ 'P5', 'Cam',   'Blue',  12.0, 'Paris'  ],
    [ 'P6', 'Cog',   'Red',   19.0, 'London' ],
  ]
)

# Relational Operators
# --------------------

# projection
new_relation = relation.project([ :id ])

# removal
new_relation = relation.remove([ :name ])

# rename
new_relation = relation.rename(id: :other_id, name: :other_name)

# restriction
new_relation = relation.restrict { |r| r.name.eq('Screw').or(r.city.eq('London')) }
new_relation = relation.restrict(relation.name.eq('Screw'))
new_relation = relation.restrict(name: 'Screw')
new_relation = relation.restrict([ [ :name, 'Screw' ] ])

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
new_relation = relation.summarize(relation.project([ :city ])) { |r| r.add(:count, r.id.count) }
new_relation = relation.summarize(relation.project([ :city ])) { |r| r.add(:count) { |acc, t| acc.to_i + 1 } }

# Non-Relational Operators
# ------------------------

# returns a set that represents the relation header
header = relation.header

# a relation is Enumerable
relation = relation.each { |tuple| ... }

# order by attribute and direction
ordered = relation.sort_by { |r| [ r.city.desc, r.name, r.color, r.id, r.weight ] }

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
```

## Goals

The purpose of this project is to expand my knowledge of relational algebra by attempting to implement a simple query system using the primitive operations defined in relational algebra.

Most of the design is heavily inspired from [koios](https://github.com/carllerche/koios) and [arel](https://github.com/rails/arel). The reason I decided to write my own and not just build on top of those systems was not so much because I don't like the code/API in those projects, it's more because I wanted to gain a depth of understanding that can only be earned by trying to solve the problem myself.

I should note though that I don't plan to just re-implement those systems with a different API, or different internals, I plan to make something that surpasses them in several areas. For example, I want to be able to join information from multiple datastores and represent it as a single relation. I want to be able to insert, update or delete from that relation and have those changes propagated back to the right datastore. This is not an easy feat, since it is basically the updatable view problem that RDBMS' struggle with. While I do think there are some cases where relations will become read-only, I think it will be possible to propagate writes properly in this manner. I certainly think for the current use cases in DataMapper this should work quite well.

The ability to join data from multiple datastores and have it presented in a consistent manner will solve one of the longest standing problems in DataMapper, namely how do we do cross repository joins. It should be possible to construct one query for one datastore, and then another query for another datastore and then join them. Since they are using different engines Veritas will know to perform each query *natively* and then join the results in-memory seamlessly. It should also be possible to reorganize the queries so that as much work as possible is done natively as opposed to in-memory, which is considered the last resort.

Not only does this work nicely with associations, but it will allow DataMapper to perform mapping in a more powerful way. You'll be able to construct a join from multiple datastores, and set that as the base for your model. Each DM Resource would work as normal, but again writes could be propagated back to the appropriate datastore. You'd be able to split your data up between different datastores, but assemble it into one coherent view.

### Phase 1: In-Memory Operations

The first phase of this project will be to implement all the operations listed below using in-memory data structures. I'm focusing on the API, and making sure the specs ensure the desired results are obtained from each operation.

This is 100% complete.

### Phase 2: RDBMS Engines

The second phase of this project will be to add a RDBMS based engine, and move the in-memory matching to it's own engine. I'll also be working on a system where if the primary engine cannot carry out some operation, that it first look at alternate forms (e.g. using a join instead of an intersection), and then fall-back to in-memory matching. I also want to look at re-arranging queries so that all the operations that can be performed natively are "pushed down" the hierarchy and then the in-memory matching is performed last.

This is 95% complete. I have completed a first pass on [veritas-sql-generator](https://github.com/dkubb/veritas-sql-generator) which is a visitor that walks the AST and produces SQL for every operation. More work is needed to write adapters that use the veritas-sql-generator and manage database connections/execution.

### Phase 3: DataMapper Integration

The third phase of this project will be to add a few NoSQL engines (like [MongoDB](http://www.mongodb.org/) and [CouchDB](http://couchdb.org/)) and then look at writing a DataMapper adapter that translates Query objects into Veritas relations. I want to make sure all the DM specs pass with this adapter and each engine, and if everything goes well I will look at updating DM to work directly on top of Veritas.

## Related Projects

* [veritas-optimizer](https://github.com/dkubb/veritas-optimizer)

This is an optimizer that takes a Veritas relation, scalar or aggregate function and will transform it into something equivalent but simpler in structure to the original.

* [veritas-sql-generator](https://github.com/dkubb/veritas-sql-generator)

This is a visitor class that takes a Veritas relation and generates valid SQL from it.

* [veritas-do-adapter](https://github.com/dkubb/veritas-do-adapter)

This is a system that manages the database connections and executes the SQL generated from the relations.

## Note on Patches/Pull Requests

* If you want your code merged into the mainline, please discuss the proposed changes with me before doing any work on it. This library is still in early development, and the direction it is going may not always be clear. Some features may not be appropriate yet, may need to be deferred until later when the foundation for them is laid, or may be more applicable in a plugin.
* Fork the project.
* Make your feature addition or bug fix.
  * Follow this [style guide](https://github.com/dkubb/styleguide).
* Add specs for it. This is important so I don't break it in a future version unintentionally. Tests must cover all branches within the code, and code must be fully covered.
* Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Run "rake ci". This must pass and not show any regressions in the metrics for the code to be merged.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright &copy; 2009-2012 Dan Kubb. See LICENSE for details.
