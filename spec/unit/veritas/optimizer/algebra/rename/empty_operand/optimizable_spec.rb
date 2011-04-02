require 'spec_helper'

describe Optimizer::Algebra::Rename::EmptyOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:relation) { operand.rename(:id => :other_id)           }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is an empty relation' do
    let(:operand) { Relation::Empty.new(header) }

    it { should be(true) }
  end

  context 'when the operand is not an empty relation' do
    let(:operand) { Relation.new(header, [ [ 1 ] ]) }

    it { should be(false) }
  end
end
