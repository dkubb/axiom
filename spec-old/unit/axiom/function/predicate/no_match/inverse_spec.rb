# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::NoMatch, '#inverse' do
  subject { object.inverse }

  let(:attribute) { Attribute::String.new(:name)           }
  let(:regexp)    { /Dan Kubb/.freeze                      }
  let(:object)    { described_class.new(attribute, regexp) }

  it_should_behave_like 'an invertible method'

  it { should be_instance_of(Function::Predicate::Match) }

  its(:left) { should be(attribute) }

  its(:right) { should be(regexp) }
end
