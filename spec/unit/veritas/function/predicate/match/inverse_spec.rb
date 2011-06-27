# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Match, '#inverse' do
  subject { object.inverse }

  let(:attribute) { Attribute::String.new(:name)           }
  let(:regexp)    { /Dan Kubb/.freeze                      }
  let(:object)    { described_class.new(attribute, regexp) }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Function::Predicate::NoMatch) }

  its(:left) { should equal(attribute) }

  its(:right) { should equal(regexp) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
