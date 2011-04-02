require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::ZeroOffset, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Relation::Operation::Offset::ZeroOffset       }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:relation) { base.drop(offset)                                        }
  let(:object)   { klass.new(relation)                                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Offset)
  end

  context 'when the operation offset is 0' do
    let(:offset) { 0 }

    it { should be(true) }
  end

  context 'when the operation offset is not 0' do
    let(:offset) { 1 }

    it { should be(false) }
  end
end
