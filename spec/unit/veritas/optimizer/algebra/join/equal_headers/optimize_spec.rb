require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Join::EqualHeaders#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Join::EqualHeaders     }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)    { Relation.new(header, [ [ 2 ] ].each)       }
  let(:relation) { left.join(right)                           }
  let(:object)   { klass.new(relation)                        }

  before do
    object.operation.should be_kind_of(Algebra::Join)
  end

  it { should be_kind_of(Algebra::Intersection) }

  its(:left) { should equal(left) }

  its(:right) { should equal(right) }
end
