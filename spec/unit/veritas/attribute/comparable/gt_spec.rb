require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Comparable#gt' do
  subject { comparable.gt(1) }

  let(:comparable) { ComparableSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::GreaterThan) }
end
