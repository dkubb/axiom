# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Invertible, '#inverse' do
  subject { object.inverse }

  let(:described_class) { Class.new(Function) { include Function::Unary } }
  let(:operand)         { mock('Operand').freeze                          }
  let(:object)          { described_class.new(operand)                    }

  let(:inverse_class) do
    Class.new(Function) do
      include Function::Unary::Invertible, Function::Unary
    end
  end

  before do
    described_class.class_eval do
      include Function::Unary::Invertible

      def self.inverse
        InverseClass
      end

      def inspect
        'Unary::Invertible'
      end
    end
  end

  before do
    ::InverseClass = inverse_class
  end

  after do
    Object.send(:remove_const, :InverseClass) if defined?(InverseClass)
  end

  it_should_behave_like 'an invertible method'

  it { should be_instance_of(InverseClass) }

  its(:operand) { should equal(operand) }
end
