require 'spec_helper'

describe Optimizer::Algebra::Union::EmptyLeft, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation::Empty.new(header)                }
  let(:right)    { Relation.new(header, [ [ 2 ] ].each)       }
  let(:relation) { left.union(right)                          }
  let(:object)   { described_class.new(relation)              }

  before do
    object.should be_optimizable
  end

  it { should equal(right) }
end
