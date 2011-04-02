require 'spec_helper'

describe Optimizer::Algebra::Product::TableDeeRight, '#optimizable?' do
  subject { object.optimizable? }

  let(:left)     { Relation.new([ [ :id, Integer  ] ], [ [ 1 ] ].each) }
  let(:relation) { left.product(right)                                 }
  let(:object)   { described_class.new(relation)                       }

  before do
    object.operation.should be_kind_of(Algebra::Product)
  end

  context 'when the right operand is a table dee' do
    let(:right) { TABLE_DEE }

    it { should be(true) }
  end

  context 'when the right operand is not table dee' do
    let(:right) { TABLE_DUM }

    it { should be(false) }
  end
end
