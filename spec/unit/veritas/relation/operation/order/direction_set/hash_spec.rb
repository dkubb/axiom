require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#hash' do
  subject { object.hash }

  let(:klass)      { Relation::Operation::Order::DirectionSet }
  let(:attribute)  { Attribute::Integer.new(:id)              }
  let(:directions) { [ attribute.asc ]                        }
  let(:object)     { klass.new(directions)                    }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ directions.hash }
end
