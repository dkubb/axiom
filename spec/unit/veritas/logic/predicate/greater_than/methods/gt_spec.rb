require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThan::Methods#gt' do
  subject { object.gt(other) }

  let(:klass)  { GreaterThanMethodsSpecs::Object }
  let(:other)  { 1                               }
  let(:object) { klass.new                       }

  it { should be_kind_of(Logic::Predicate::GreaterThan) }
end
