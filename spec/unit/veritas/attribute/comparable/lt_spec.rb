require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Comparable#lt' do
  before do
    @comparable = ComparableSpecs::Object.new
  end

  subject { @comparable.lt(1) }

  it { should be_kind_of(Logic::Predicate::LessThan) }
end
