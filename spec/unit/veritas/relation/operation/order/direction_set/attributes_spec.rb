require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#attributes' do
  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

  subject { directions.attributes }

  it { should be_kind_of(Array) }

  it { should == [ attribute ] }
end
