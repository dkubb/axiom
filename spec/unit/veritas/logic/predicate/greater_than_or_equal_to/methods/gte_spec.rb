require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::GreaterThanOrEqualTo::Methods, '#gte' do
  subject { object.gte(other) }

  let(:described_class) { GreaterThanOrEqualToMethodsSpecs::Object }
  let(:other)           { 1                                        }
  let(:object)          { described_class.new                      }

  it { should be_kind_of(Logic::Predicate::GreaterThanOrEqualTo) }
end
