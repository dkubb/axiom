require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Comparable#gte' do
  subject { comparable.gte(1) }

  let(:comparable) { ComparableSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::GreaterThanOrEqualTo) }
end
