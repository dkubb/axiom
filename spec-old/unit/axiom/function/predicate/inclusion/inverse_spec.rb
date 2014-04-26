# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Inclusion, '#inverse' do
  subject { object.inverse }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:enumerable) { [1].freeze                                 }
  let(:object)     { described_class.new(attribute, enumerable) }

  it_should_behave_like 'an invertible method'

  it { should be_instance_of(Function::Predicate::Exclusion) }

  its(:left) { should be(attribute) }

  its(:right) { should be(enumerable) }
end
