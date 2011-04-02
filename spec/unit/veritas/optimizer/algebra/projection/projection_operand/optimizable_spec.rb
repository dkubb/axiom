require 'spec_helper'

describe Optimizer::Algebra::Projection::ProjectionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Algebra::Projection::ProjectionOperand                                }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb', 35 ] ].each)                             }
  let(:relation) { operand.project([ :id ])                                                         }
  let(:object)   { klass.new(relation)                                                              }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  context 'when the operand is a projection' do
    let(:operand) { base.project([ :id, :name ]) }

    it { should be(true) }
  end

  context 'when the operand is not a projection' do
    let(:operand) { base }

    it { should be(false) }
  end
end
