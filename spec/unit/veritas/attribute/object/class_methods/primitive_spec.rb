require 'spec_helper'

describe 'Veritas::Attribute::Object.primitive' do
  subject { Attribute::Object.primitive }

  it { should equal(Object) }
end
