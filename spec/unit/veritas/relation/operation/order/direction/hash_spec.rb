require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#hash' do
  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:direction) { klass.new(attribute)                             }

  subject { direction.hash }

  it { should be_kind_of(Integer) }

  it { should == direction.attribute.hash }
end
