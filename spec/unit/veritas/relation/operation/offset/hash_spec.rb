require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#hash' do
  subject { object.hash }

  let(:klass)    { Relation::Operation::Offset                                 }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:operand)  { relation.order                                              }
  let(:offset)   { 1                                                           }
  let(:object)   { klass.new(operand, offset)                                  }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ operand.hash ^ offset.hash }
end
