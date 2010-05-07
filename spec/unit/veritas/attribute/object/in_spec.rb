require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#in' do
  subject { attribute.in([ { :active => true }, { :active => false } ]) }

  let(:attribute) { Attribute::Object.new(:data) }

  it { should be_kind_of(Logic::Predicate::Inclusion) }
end
