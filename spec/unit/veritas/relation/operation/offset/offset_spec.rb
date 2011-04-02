require 'spec_helper'

describe Relation::Operation::Offset, '#offset' do
  subject { object.offset }

  let(:klass)    { Relation::Operation::Offset                                 }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.order                                              }
  let(:offset)   { 1                                                           }
  let(:object)   { klass.new(order, offset)                                    }

  it { should == offset }
end
