require 'spec_helper'

describe 'Veritas::Attribute::Integer.primitive' do
  subject { Attribute::Integer.primitive }

  it { should equal(Integer) }
end
