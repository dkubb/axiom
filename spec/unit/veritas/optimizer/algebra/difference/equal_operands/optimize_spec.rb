require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Difference::EqualOperands#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Difference::EqualOperands }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])    }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)          }
  let(:right)    { Relation.new(header, [ [ 1 ] ].each)          }
  let(:relation) { left.difference(right)                        }
  let(:object)   { klass.new(relation)                           }

  before do
    object.operation.should be_kind_of(Algebra::Difference)
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(header) }
end
