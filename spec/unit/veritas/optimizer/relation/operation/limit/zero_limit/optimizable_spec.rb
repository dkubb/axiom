require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::ZeroLimit, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:relation) { base.take(limit)                                         }
  let(:object)   { described_class.new(relation)                            }

  before do
    object.operation.should be_kind_of(Relation::Operation::Limit)
  end

  context 'when the operation limit is 0' do
    let(:limit) { 0 }

    it { should be(true) }
  end

  context 'when the operation limit is not 0' do
    let(:limit) { 1 }

    it { should be(false) }
  end
end
