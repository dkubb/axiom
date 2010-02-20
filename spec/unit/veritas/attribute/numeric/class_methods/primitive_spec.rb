require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Numeric.primitive' do
  subject { Attribute::Numeric.primitive }

  it { should equal(Numeric) }
end
