require 'spec_helper'

describe Optimizer::Algebra::Restriction::SetOperand, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)      { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)     { Relation.new(header, [ [ 2 ] ].each)       }
  let(:predicate) { header[:id].eq(1)                          }
  let(:relation)  { left.union(right).restrict(predicate)      }
  let(:object)    { described_class.new(relation)              }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Set) }

  its(:left) { should eql(left.restrict(predicate)) }

  its(:right) { should eql(right.restrict(predicate)) }
end
