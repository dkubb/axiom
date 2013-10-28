# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::LessThanOrEqualTo::Methods, '#lte' do
  subject { object.lte(other) }

  let(:object)          { described_class.new.freeze            }
  let(:described_class) { LessThanOrEqualToMethodsSpecs::Object }
  let(:other)           { 1                                     }

  it { should be_instance_of(Function::Predicate::LessThanOrEqualTo) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
