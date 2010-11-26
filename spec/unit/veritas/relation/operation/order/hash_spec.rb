require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#hash' do
  subject { object.hash }

  let(:klass)      { Relation::Operation::Order                           }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { klass::DirectionSet.new(operand.header)              }
  let(:object)     { klass.new(operand, directions)                       }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ operand.hash ^ directions.hash }
end
