require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Time.primitive' do
  subject { Attribute::Time.primitive }

  it { should equal(Time) }
end
