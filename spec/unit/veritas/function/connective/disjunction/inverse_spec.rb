# encoding: utf-8

require 'spec_helper'

describe Function::Connective::Disjunction, '#inverse' do
  subject { object.inverse }

  let(:attribute) { Attribute::Integer.new(:id)      }
  let(:left)      { attribute.gt(1)                  }
  let(:right)     { attribute.lt(3)                  }
  let(:object)    { described_class.new(left, right) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Function::Connective::Conjunction) }

  its(:left) { should eql(Function::Connective::Negation.new(object.left)) }

  its(:right) { should eql(Function::Connective::Negation.new(object.right)) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
