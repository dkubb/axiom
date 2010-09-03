require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Complement::ComplementableOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)      { Optimizer::Logic::Connective::Complement::ComplementableOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                                     }
  let(:complement) { Logic::Connective::Complement.new(operand)                      }
  let(:object)     { klass.new(complement)                                           }

  before do
    object.operation.should be_kind_of(Logic::Connective::Complement)
  end

  context 'when operand is complementable' do
    let(:operand) { attribute.eq(1) }

    it { should be(true) }
  end

  context 'when operand is not complementable' do
    let(:operand) { proc { true } }

    it { should be(false) }
  end

end
