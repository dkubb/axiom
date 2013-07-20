# encoding: utf-8

require 'spec_helper'

describe Function::Binary::Invertible, '#inverse' do
  subject { object.inverse }

  let(:described_class) { Class.new(Function) { include Function::Binary } }
  let(:left)            { double('Left').freeze                            }
  let(:right)           { double('Right').freeze                           }
  let(:object)          { described_class.new(left, right)                 }

  let(:inverse_class) do
    Class.new(Function) do
      include Function::Binary::Invertible, Function::Binary
    end
  end

 before do
    described_class.class_eval do
      include Function::Binary::Invertible

      def self.inverse
        InverseClass
      end

      def inspect
        'Binary::Invertible'
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

  its(:left)  { should equal(left)  }
  its(:right) { should equal(right) }
end
