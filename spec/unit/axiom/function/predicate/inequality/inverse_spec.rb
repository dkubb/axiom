# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Inequality, '#inverse' do
  subject { object.inverse }

  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:object)    { described_class.new(attribute, 1) }

  it_should_behave_like 'an invertible method'

  it { should be_instance_of(Function::Predicate::Equality) }

  its(:left) { should be(attribute) }

  its(:right) { should == 1 }
end
