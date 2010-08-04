require 'spec_helper'

describe 'Veritas::Operation::Unary#optimized?' do
  subject { unary_operation.optimized? }

  let(:klass)             { Class.new { include Operation::Unary } }
  let(:operand)           { mock('Operand')                        }
  let(:unary_operation)   { klass.new(operand)                     }
  let(:optimized_operand) { mock('Optimized Operand')              }

  context 'operand is optimized' do
    before do
      operand.stub!(:optimize).and_return(operand)
    end

    it { should be(true) }
  end

  context 'operand is not optimized' do
    before do
      operand.stub!(:optimize).and_return(optimized_operand)
    end

    it { should be(false) }
  end
end
