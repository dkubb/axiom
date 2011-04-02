require 'spec_helper'

describe Optimizer::Algebra::Product::TableDeeLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Algebra::Product::TableDeeLeft           }
  let(:right)    { Relation.new([ [ :id, Integer  ] ], [ [ 1 ] ].each) }
  let(:relation) { left.product(right)                                 }
  let(:object)   { klass.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Product)
  end

  context 'when the left operand is a table dee' do
    let(:left) { TABLE_DEE }

    it { should be(true) }
  end

  context 'when the left operand is not table dee' do
    let(:left) { TABLE_DUM }

    it { should be(false) }
  end
end
