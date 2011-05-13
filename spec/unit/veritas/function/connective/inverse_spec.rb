# encoding: utf-8

require 'spec_helper'

describe Function::Connective, '#inverse' do
  subject { object.inverse }

  let(:described_class) { Class.new(Function::Connective) }
  let(:object)          { described_class.new             }

  before do
    described_class.class_eval do
      def inspect
        'Connective()'
      end
    end
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Function::Connective::Negation) }

  its(:operand) { should equal(object) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
