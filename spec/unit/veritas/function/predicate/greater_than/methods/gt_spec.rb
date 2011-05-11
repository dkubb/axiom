require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::GreaterThan::Methods, '#gt' do
  subject { object.gt(other) }

  let(:described_class) { GreaterThanMethodsSpecs::Object }
  let(:other)           { 1                               }
  let(:object)          { described_class.new             }

  it { should be_kind_of(Function::Predicate::GreaterThan) }
end
