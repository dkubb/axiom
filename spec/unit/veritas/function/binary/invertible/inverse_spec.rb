# encoding: utf-8

require 'spec_helper'

describe Function::Binary::Invertible, '#inverse' do
  subject { object.inverse }

  let(:described_class) { Class.new(Function) { include Function::Binary } }
  let(:left)            { mock('Left').freeze                              }
  let(:right)           { mock('Right').freeze                             }
  let(:object)          { described_class.new(left, right)                 }

  before do
    described_class.class_eval do
      include Function::Binary::Invertible

      def self.inverse
        self
      end

      def inspect
        'Binary::Invertible'
      end
    end
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(described_class) }

  it { should_not equal(object) }

  its(:left)  { should equal(left)  }
  its(:right) { should equal(right) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
