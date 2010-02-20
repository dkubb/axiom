require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Integer.primitive' do
  subject { Attribute::Integer.primitive }

  it { should equal(Integer) }
end
