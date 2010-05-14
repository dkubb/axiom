require 'spec_helper'

describe 'Veritas::Attribute::String.primitive' do
  subject { Attribute::String.primitive }

  it { should equal(String) }
end
