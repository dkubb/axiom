require 'spec_helper'

describe 'Veritas::Attribute::Float.primitive' do
  subject { Attribute::Float.primitive }

  it { should equal(Float) }
end
