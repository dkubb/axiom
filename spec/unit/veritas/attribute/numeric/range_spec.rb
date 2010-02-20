require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Numeric#range' do
  it 'is an alias to #size' do
    klass = Attribute::Numeric
    klass.instance_method(:range).should == klass.instance_method(:size)
  end
end
