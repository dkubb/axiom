require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Boolean.primitive' do
  subject { Attribute::Boolean.primitive }

  it { should equal(TrueClass) }
end
