require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#hash' do
  subject { object.hash }

  let(:klass)     { Relation::Operation::Order::DirectionSet }
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:object)    { klass.new([ attribute ])                 }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == [ attribute.asc ].hash }
end
