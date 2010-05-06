require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#to_ary' do
  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

  subject { directions.to_ary }

  it { should be_instance_of(Array) }

  it { should == [ attribute.asc ] }
end
