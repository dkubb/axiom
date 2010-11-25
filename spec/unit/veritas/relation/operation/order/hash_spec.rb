require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#hash' do
  subject { object.hash }

  let(:klass)      { Relation::Operation::Order                           }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { klass::DirectionSet.new(operand.header)              }
  let(:object)     { klass.new(operand, directions)                       }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == operand.hash ^ directions.hash }
end
