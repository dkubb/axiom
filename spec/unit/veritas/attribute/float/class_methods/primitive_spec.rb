require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Float.primitive' do
  subject { Attribute::Float.primitive }

  it { should equal(Float) }
end
