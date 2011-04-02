require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#to_ary' do
  subject { object.to_ary }

  let(:klass)     { Relation::Operation::Order::DirectionSet }
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:object)    { klass.new([ attribute ])                 }

  it { should be_kind_of(Array) }

  it { should == [ attribute.asc ] }
end
