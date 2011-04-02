require 'spec_helper'

describe Optimizer::Algebra::Rename::SetOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::SetOperand            }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)              }
  let(:right)    { Relation.new(header, [ [ 2 ] ].each)              }
  let(:relation) { left.union(right).rename(:id => :other_id)        }
  let(:object)   { klass.new(relation)                               }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Operation::Set)
  end

  it { should be_kind_of(Relation::Operation::Set) }

  its(:left) { should eql(left.rename(:id => :other_id)) }

  its(:right) { should eql(right.rename(:id => :other_id)) }
end
