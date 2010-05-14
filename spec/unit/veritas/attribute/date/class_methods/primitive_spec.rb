require 'spec_helper'

describe 'Veritas::Attribute::Date.primitive' do
  subject { Attribute::Date.primitive }

  it { should equal(Date) }
end
