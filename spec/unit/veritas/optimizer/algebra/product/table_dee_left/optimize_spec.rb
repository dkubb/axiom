require 'spec_helper'

describe Optimizer::Algebra::Product::TableDeeLeft, '#optimize' do
  subject { object.optimize }

  let(:left)     { TABLE_DEE                                           }
  let(:right)    { Relation.new([ [ :id, Integer  ] ], [ [ 1 ] ].each) }
  let(:relation) { left.product(right)                                 }
  let(:object)   { described_class.new(relation)                       }

  before do
    object.operation.should be_kind_of(Algebra::Product)
  end

  it { should equal(right) }
end
