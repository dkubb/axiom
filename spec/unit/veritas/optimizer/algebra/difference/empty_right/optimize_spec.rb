require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Difference::EmptyRight#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Difference::EmptyRight }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)    { Relation::Empty.new(header)                }
  let(:relation) { left.difference(right)                     }
  let(:object)   { klass.new(relation)                        }

  before do
    object.operation.should be_kind_of(Algebra::Difference)
  end

  it { should equal(left) }
end
