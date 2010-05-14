require 'spec_helper'

describe 'Veritas::Attribute::Time.primitive' do
  subject { Attribute::Time.primitive }

  it { should equal(Time) }
end
