require 'spec_helper'

describe 'Veritas::Attribute::DateTime#range' do
  subject { object.range }

  let(:klass)  { Attribute::DateTime  }
  let(:object) { klass.new(:datetime) }

  it { should == (DateTime.new..DateTime::Infinity.new) }
end
