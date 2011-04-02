require 'spec_helper'

describe Optimizer::Algebra::Union::EqualOperands, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)    { Relation.new(header, [ [ 1 ] ].each)       }
  let(:relation) { left.union(right)                          }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Union)
  end

  it { should equal(left) }
end
