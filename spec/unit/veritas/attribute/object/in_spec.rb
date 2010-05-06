require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#in' do
  let(:attribute) { Attribute::Object.new(:data) }

  subject { attribute.in([ { :active => true }, { :active => false } ]) }

  it { should be_kind_of(Logic::Predicate::Inclusion) }
end
