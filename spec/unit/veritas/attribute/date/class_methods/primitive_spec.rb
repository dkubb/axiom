require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Date.primitive' do
  subject { Attribute::Date.primitive }

  it { should equal(Date) }
end
