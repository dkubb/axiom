require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#match' do
  let(:attribute) { Attribute::String.new(:name) }

  subject { attribute.match(/Dan Kubb/) }

  it { should be_kind_of(Logic::Predicate::Match) }
end
