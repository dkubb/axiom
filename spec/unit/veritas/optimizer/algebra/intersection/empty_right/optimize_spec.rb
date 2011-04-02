require 'spec_helper'

describe Optimizer::Algebra::Intersection::EmptyRight, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)    { Relation::Empty.new(header)                }
  let(:relation) { left.intersect(right)                      }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Intersection)
  end

  it { should equal(right) }
end
