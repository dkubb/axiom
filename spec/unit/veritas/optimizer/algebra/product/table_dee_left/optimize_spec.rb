require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Product::TableDeeLeft#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Product::TableDeeLeft           }
  let(:left)     { TABLE_DEE                                           }
  let(:right)    { Relation.new([ [ :id, Integer  ] ], [ [ 1 ] ].each) }
  let(:relation) { left.product(right)                                 }
  let(:object)   { klass.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Product)
  end

  it { should equal(right) }
end
