require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#reverse' do
  subject { object.reverse }

  let(:klass)      { Relation::Operation::Order::DirectionSet }
  let(:attribute1) { Attribute::Integer.new(:id)              }
  let(:attribute2) { Attribute::String.new(:name)             }
  let(:object)     { klass.new([ attribute1, attribute2 ])    }

  it { should be_kind_of(klass) }

  it 'reverses each direction' do
    should == [ attribute1.desc, attribute2.desc ]
  end

  it 'does not reverse the attribute order' do
    subject.attributes.should == [ attribute1, attribute2 ]
  end
end
