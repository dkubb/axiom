require 'spec_helper'

describe Optimizer::Algebra::Intersection::EqualOperands, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Intersection::EqualOperands }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])      }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)            }
  let(:right)    { Relation.new(header, [ [ 1 ] ].each)            }
  let(:relation) { left.intersect(right)                           }
  let(:object)   { klass.new(relation)                             }

  before do
    object.operation.should be_kind_of(Algebra::Intersection)
  end

  it { should equal(left) }
end
