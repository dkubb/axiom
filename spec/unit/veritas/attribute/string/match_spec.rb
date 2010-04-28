require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#match' do
  before do
    @attribute = Attribute::String.new(:name)
  end

  subject { @attribute.match(/Dan Kubb/) }

  it { should be_kind_of(Logic::Predicate::Match) }
end
