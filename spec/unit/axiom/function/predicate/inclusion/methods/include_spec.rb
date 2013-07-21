# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Inclusion::Methods, '#include' do
  subject { object.include(other) }

  let(:described_class) { InclusionMethodsSpecs::Object }
  let(:other)           { [true, false]                 }
  let(:object)          { described_class.new           }

  it { should be_instance_of(Function::Predicate::Inclusion) }
end
