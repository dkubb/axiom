require 'spec_helper'

describe Optimizer::Algebra::Union::EmptyRight, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Union::EmptyRight      }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)    { Relation.new(header, [ [ 2 ] ].each)       }
  let(:relation) { left.union(right)                          }
  let(:object)   { klass.new(relation)                        }

  before do
    object.operation.should be_kind_of(Algebra::Union)
  end

  it { should equal(left) }
end
