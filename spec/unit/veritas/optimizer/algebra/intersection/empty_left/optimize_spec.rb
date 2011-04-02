require 'spec_helper'

describe Optimizer::Algebra::Intersection::EmptyLeft, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation::Empty.new(header)                }
  let(:right)    { Relation.new(header, [ [ 1 ] ].each)       }
  let(:relation) { left.intersect(right)                      }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Intersection)
  end

  it { should equal(left) }
end
