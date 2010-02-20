require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String.primitive' do
  subject { Attribute::String.primitive }

  it { should equal(String) }
end
