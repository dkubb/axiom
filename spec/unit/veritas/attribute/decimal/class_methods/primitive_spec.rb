require 'spec_helper'

describe 'Veritas::Attribute::Decimal.primitive' do
  subject { Attribute::Decimal.primitive }

  it { should equal(BigDecimal) }
end
