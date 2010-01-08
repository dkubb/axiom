require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#==' do
  it 'is an alias to #eql?' do
    klass = Veritas::Relation::Operation::Order::Direction
    klass.instance_method(:==).should == klass.instance_method(:eql?)
  end
end
