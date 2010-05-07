require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Comparable#lt' do
  subject { comparable.lt(1) }

  let(:comparable) { ComparableSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::LessThan) }
end
