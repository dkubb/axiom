require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#to_ary' do
  subject { directions.to_ary }

  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

  it { should be_instance_of(Array) }

  it { should == [ attribute.asc ] }
end
