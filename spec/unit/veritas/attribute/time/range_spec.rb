require 'spec_helper'

describe 'Veritas::Attribute::Time#range' do
  subject { object.range }

  let(:klass)  { Attribute::Time  }
  let(:object) { klass.new(:time) }

  it { should == (Time.at(0)..Time.at(2**31-1)) }
end
