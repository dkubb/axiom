require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#to_ary' do
  subject { object.to_ary }

  let(:attribute) { Attribute::Integer.new(:id)        }
  let(:object)    { described_class.new([ attribute ]) }

  it { should be_kind_of(Array) }

  it { should == [ attribute.asc ] }
end
