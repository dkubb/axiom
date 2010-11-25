require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#hash' do
  subject { object.hash }

  let(:klass)    { Relation::Operation::Offset                                 }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:operand)  { relation.order                                              }
  let(:offset)   { 1                                                           }
  let(:object)   { klass.new(operand, offset)                                  }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == operand.hash ^ offset.hash }
end
