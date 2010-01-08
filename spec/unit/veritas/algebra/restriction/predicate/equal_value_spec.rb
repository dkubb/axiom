require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#==' do
  it 'is an alias to #eql?' do
    klass = Algebra::Restriction::Predicate
    klass.instance_method(:==).should == klass.instance_method(:eql?)
  end
end
