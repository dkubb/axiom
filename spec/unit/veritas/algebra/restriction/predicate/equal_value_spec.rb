require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Predicate#==' do
  it 'is an alias to #eql?' do
    Algebra::Restriction::Predicate.instance_method(:==).should == Algebra::Restriction::Predicate.instance_method(:eql?)
  end
end
