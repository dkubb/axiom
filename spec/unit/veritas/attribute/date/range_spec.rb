require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Date#range' do
  before do
    @attribute = Veritas::Attribute::Date.new(:date)
  end

  subject { @attribute.range }

  it { should == (Date.new..Date::Infinity.new) }
end
