require 'spec_helper'

describe 'Veritas::Attribute::Date#range' do
  subject { object.range }

  let(:klass)  { Attribute::Date  }
  let(:object) { klass.new(:date) }

  it { should == (Date.new..Date::Infinity.new) }
end
