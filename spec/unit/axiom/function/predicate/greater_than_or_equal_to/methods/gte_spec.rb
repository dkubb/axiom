# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::GreaterThanOrEqualTo::Methods, '#gte' do
  subject { object.gte(other) }

  let(:object)          { described_class.new.freeze               }
  let(:described_class) { GreaterThanOrEqualToMethodsSpecs::Object }
  let(:other)           { 1                                        }

  it { should be_instance_of(Function::Predicate::GreaterThanOrEqualTo) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
