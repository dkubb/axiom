require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Class.primitive' do
  subject { Attribute::Class.primitive }

  it { should equal(Class) }
end
