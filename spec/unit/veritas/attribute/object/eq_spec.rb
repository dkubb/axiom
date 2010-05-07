require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#eq' do
  subject { attribute.eq(:active => true) }

  let(:attribute) { Attribute::Object.new(:data) }

  it { should be_kind_of(Logic::Predicate::Equality) }
end
