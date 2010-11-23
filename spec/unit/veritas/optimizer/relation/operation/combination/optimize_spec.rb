require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Combination#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Relation::Operation::Combination }
  let(:left)     { Relation.new([ [ :id, Integer ] ], [])      }
  let(:right)    { Relation.new([ [ :id, Integer ] ], [])      }
  let(:relation) { left.join(right)                            }
  let(:object)   { klass.new(relation)                         }

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(relation.header) }
end
