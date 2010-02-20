require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::DateTime.primitive' do
  subject { Attribute::DateTime.primitive }

  it { should equal(DateTime) }
end
