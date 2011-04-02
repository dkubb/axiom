require 'spec_helper'

describe Optimizer::Algebra::Projection::EmptyOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Algebra::Projection::EmptyOperand                  }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:relation) { operand.project([ :id ])                                      }
  let(:object)   { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  context 'when the operand is empty' do
    let(:operand) { Relation::Empty.new(header) }

    it { should be(true) }
  end

  context 'when the operand is not empty' do
    let(:operand) { Relation.new(header, [ [ 1, 'Dan Kubb' ] ]) }

    it { should be(false) }
  end
end
