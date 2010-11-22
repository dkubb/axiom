require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo::Methods#lte' do
  subject { object.lte(other) }

  let(:klass)  { LessThanOrEqualToMethodsSpecs::Object }
  let(:other)  { 1                                     }
  let(:object) { klass.new                             }

  it { should be_kind_of(Logic::Predicate::LessThanOrEqualTo) }
end
