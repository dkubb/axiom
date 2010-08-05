require 'spec_helper'

describe 'Veritas::Operation::Unary#new_optimized_operation' do
  subject { unary_operation.new_optimized_operation }

  let(:klass)           { Class.new { include Operation::Unary } }
  let(:operand)         { mock('Operand')                        }
  let(:unary_operation) { klass.new(operand)                     }

  before do
    klass.class_eval do
      def new(operand)
        self.class.new(operand)
      end
    end
  end

  it { should be_kind_of(klass) }

  its(:operand) { should equal(operand) }
end
