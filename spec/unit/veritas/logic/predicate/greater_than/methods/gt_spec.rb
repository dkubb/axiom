require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::GreaterThan::Methods, '#gt' do
  subject { object.gt(other) }

  let(:described_class) { GreaterThanMethodsSpecs::Object }
  let(:other)           { 1                               }
  let(:object)          { described_class.new             }

  it { should be_kind_of(Logic::Predicate::GreaterThan) }
end
