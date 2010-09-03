require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Product::TableDeeRight#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Product::TableDeeRight          }
  let(:left)     { Relation.new([ [ :id, Integer  ] ], [ [ 1 ] ].each) }
  let(:right)    { TABLE_DEE                                           }
  let(:relation) { left.product(right)                                 }
  let(:object)   { klass.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Product)
  end

  it { should equal(left) }
end
