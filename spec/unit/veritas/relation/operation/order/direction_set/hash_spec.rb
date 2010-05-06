require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#hash' do
  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

  subject { directions.hash }

  it { should be_kind_of(Integer) }

  it { should == [ attribute.asc ].hash }
end
