require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#drop' do
  it 'is an alias to #offset' do
    klass = Relation
    klass.instance_method(:drop).should == klass.instance_method(:offset)
  end
end
