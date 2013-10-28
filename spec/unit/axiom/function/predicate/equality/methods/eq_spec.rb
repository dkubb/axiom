# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Equality::Methods, '#eq' do
  subject { object.eq(other) }

  let(:object)          { described_class.new.freeze   }
  let(:described_class) { EqualityMethodsSpecs::Object }
  let(:other)           { true                         }

  it { should be_instance_of(Function::Predicate::Equality) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
