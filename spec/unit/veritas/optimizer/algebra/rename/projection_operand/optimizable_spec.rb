require 'spec_helper'

describe Optimizer::Algebra::Rename::ProjectionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { operand.rename(:id => :other_id)                              }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is a projection' do
    let(:operand) { base.project([ :id ]) }

    it { should be(true) }
  end

  context 'when the operand is not a projection' do
    let(:operand) { base }

    it { should be(false) }
  end
end
