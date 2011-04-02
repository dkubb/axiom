require 'spec_helper'

describe Relation::Operation::Offset, '#hash' do
  subject { object.hash }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:operand)  { relation.order                                              }
  let(:offset)   { 1                                                           }
  let(:object)   { described_class.new(operand, offset)                        }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash ^ offset.hash }
end
