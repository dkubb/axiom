require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#attributes' do
  subject { object.attributes }

  let(:klass)     { Relation::Operation::Order::DirectionSet }
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:object)    { klass.new([ attribute ])                 }

  it { should be_kind_of(Array) }

  it { should == [ attribute ] }
end
