require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#attributes' do
  subject { directions.attributes }

  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

  it { should be_kind_of(Array) }

  it { should == [ attribute ] }
end
