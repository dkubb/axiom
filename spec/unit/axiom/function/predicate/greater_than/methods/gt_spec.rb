# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::GreaterThan::Methods, '#gt' do
  subject { object.gt(other) }

  let(:object)          { described_class.new.freeze      }
  let(:described_class) { GreaterThanMethodsSpecs::Object }
  let(:other)           { 1                               }

  it { should be_instance_of(Function::Predicate::GreaterThan) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
