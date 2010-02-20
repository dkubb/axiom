require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Decimal.primitive' do
  subject { Attribute::Decimal.primitive }

  it { should equal(BigDecimal) }
end
