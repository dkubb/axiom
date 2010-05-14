require 'spec_helper'

describe 'Veritas::Attribute::Boolean.primitive' do
  subject { Attribute::Boolean.primitive }

  it { should equal(TrueClass) }
end
