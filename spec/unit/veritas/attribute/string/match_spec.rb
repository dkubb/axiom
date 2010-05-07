require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#match' do
  subject { attribute.match(/Dan Kubb/) }

  let(:attribute) { Attribute::String.new(:name) }

  it { should be_kind_of(Logic::Predicate::Match) }
end
