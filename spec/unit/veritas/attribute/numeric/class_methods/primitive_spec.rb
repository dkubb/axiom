require 'spec_helper'

describe 'Veritas::Attribute::Numeric.primitive' do
  subject { Attribute::Numeric.primitive }

  it { should equal(Numeric) }
end
