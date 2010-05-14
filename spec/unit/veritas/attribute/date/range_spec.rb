require 'spec_helper'

describe 'Veritas::Attribute::Date#range' do
  subject { attribute.range }

  let(:attribute) { Veritas::Attribute::Date.new(:date) }

  it { should == (Date.new..Date::Infinity.new) }
end
