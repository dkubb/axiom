# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Invertible, '#inverse' do
  subject { object.inverse }

  let(:described_class) { Class.new(Function) { include Function::Unary } }
  let(:operand)         { mock('Operand').freeze                          }
  let(:object)          { described_class.new(operand)                    }

  before do
    described_class.class_eval do
      include Function::Unary::Invertible

      def self.inverse
        self
      end

      def inspect
        'Unary::Invertible'
      end
    end
  end

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(described_class) }

  it { should_not equal(object) }

  its(:operand) { should equal(operand) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
