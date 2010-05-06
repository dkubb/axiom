require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#eq' do
  let(:attribute) { Attribute::Object.new(:data) }

  subject { attribute.eq(:active => true) }

  it { should be_kind_of(Logic::Predicate::Equality) }
end
