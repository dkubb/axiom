require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#reverse' do
  subject { directions.reverse }

  let(:attribute1) { Attribute::Integer.new(:id)                                              }
  let(:attribute2) { Attribute::String.new(:name)                                             }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute1, attribute2 ]) }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it 'reverses each direction' do
    should == [ attribute1.desc, attribute2.desc ]
  end

  it 'does not reverse the attribute order' do
    subject.attributes.should == [ attribute1, attribute2 ]
  end
end
