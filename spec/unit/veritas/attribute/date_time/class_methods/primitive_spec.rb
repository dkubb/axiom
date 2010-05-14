require 'spec_helper'

describe 'Veritas::Attribute::DateTime.primitive' do
  subject { Attribute::DateTime.primitive }

  it { should equal(DateTime) }
end
