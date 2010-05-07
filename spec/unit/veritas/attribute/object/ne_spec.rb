require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object#ne' do
  subject { attribute.ne(:active => true) }

  let(:attribute) { Attribute::Object.new(:data) }

  it { should be_kind_of(Logic::Predicate::Inequality) }
end
