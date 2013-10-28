# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::LessThan::Methods, '#lt' do
  subject { object.lt(other) }

  let(:object)          { described_class.new.freeze   }
  let(:described_class) { LessThanMethodsSpecs::Object }
  let(:other)           { 1                            }

  it { should be_instance_of(Function::Predicate::LessThan) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
