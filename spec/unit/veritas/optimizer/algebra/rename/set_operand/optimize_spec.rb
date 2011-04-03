require 'spec_helper'

describe Optimizer::Algebra::Rename::SetOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)    { Relation.new(header, [ [ 2 ] ].each)       }
  let(:relation) { left.union(right).rename(:id => :other_id) }
  let(:object)   { described_class.new(relation)              }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Set) }

  its(:left) { should eql(left.rename(:id => :other_id)) }

  its(:right) { should eql(right.rename(:id => :other_id)) }
end
