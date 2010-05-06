require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#ne' do
  let(:attribute) { Attribute::Object.new(:data) }

  subject { attribute.ne(:active => true) }

  it { should be_kind_of(Logic::Predicate::Inequality) }
end
