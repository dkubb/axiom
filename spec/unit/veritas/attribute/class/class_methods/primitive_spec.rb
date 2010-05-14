require 'spec_helper'

describe 'Veritas::Attribute::Class.primitive' do
  subject { Attribute::Class.primitive }

  it { should equal(Class) }
end
