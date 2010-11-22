require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo::Methods#gte' do
  subject { object.gte(other) }

  let(:klass)  { GreaterThanOrEqualToMethodsSpecs::Object }
  let(:other)  { 1                                        }
  let(:object) { klass.new                                }

  it { should be_kind_of(Logic::Predicate::GreaterThanOrEqualTo) }
end
