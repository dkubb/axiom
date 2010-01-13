require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#take' do
  it 'is an alias to #limit' do
    klass = Relation
    klass.instance_method(:take).should == klass.instance_method(:limit)
  end
end
