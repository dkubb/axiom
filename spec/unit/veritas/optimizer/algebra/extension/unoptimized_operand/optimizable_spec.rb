require 'spec_helper'

describe Optimizer::Algebra::Extension::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)      { Optimizer::Algebra::Extension::UnoptimizedOperand }
  let(:header)     { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:base)       { Relation.new(header, [ [ 1 ] ].each)              }
  let(:extensions) { [ :text, lambda { |tuple| 1 } ]                   }
  let(:relation)   { operand.extend { |r| r.add(*extensions) }         }
  let(:object)     { klass.new(relation)                               }

  before do
    object.operation.should be_kind_of(Algebra::Extension)
  end

  context 'when the operand is optimizable' do
    let(:operand) { base.rename({}) }

    it { should be(true) }
  end

  context 'when the operand is not optimizable' do
    let(:operand) { base }

    it { should be(false) }
  end
end
