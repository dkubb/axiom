require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Date#range' do
  subject { attribute.range }

  let(:attribute) { Veritas::Attribute::Date.new(:date) }

  it { should == (Date.new..Date::Infinity.new) }
end
