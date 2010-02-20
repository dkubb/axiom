require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Object.primitive' do
  subject { Attribute::Object.primitive }

  it { should equal(Object) }
end
