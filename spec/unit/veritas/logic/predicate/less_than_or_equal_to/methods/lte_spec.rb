require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::LessThanOrEqualTo::Methods, '#lte' do
  subject { object.lte(other) }

  let(:described_class) { LessThanOrEqualToMethodsSpecs::Object }
  let(:other)           { 1                                     }
  let(:object)          { described_class.new                   }

  it { should be_kind_of(Logic::Predicate::LessThanOrEqualTo) }
end
