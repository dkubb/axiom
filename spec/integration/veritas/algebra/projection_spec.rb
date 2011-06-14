# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection do
  context 'remove attributes in predicate' do
    subject { restriction.project([ :name ]) }

    let(:left)        { Relation.new([ [ :id, Integer ] ], (1..100).map { |n| [ n ] })                          }
    let(:right)       { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ], [ 'John Doe' ], [ 'Jane Doe' ] ]) }
    let(:relation)    { left * right                                                                            }
    let(:restriction) { relation.restrict { |r| r.id.gte(1).and(r.id.lte(10)).and(r.name.eq('Dan Kubb')) }      }

    it 'returns a relation with a single tuple' do
      should == [ [ 'Dan Kubb' ] ]
    end
  end
end
