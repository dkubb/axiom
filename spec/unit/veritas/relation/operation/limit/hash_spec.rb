require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit#hash' do
  subject { object.hash }

  let(:klass)    { Relation::Operation::Limit                                  }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:operand)  { relation.order                                              }
  let(:limit)    { 1                                                           }
  let(:object)   { klass.new(operand, limit)                                   }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ operand.hash ^ limit.hash }
end
