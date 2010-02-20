require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::String#range' do
  it 'is an alias to #length' do
    klass = Attribute::String
    klass.instance_method(:range).should == klass.instance_method(:length)
  end
end
