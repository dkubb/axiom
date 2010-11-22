require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit#to_i' do
  subject { object.to_i }

  let(:klass)      { Relation::Operation::Limit                                  }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)      { relation.order                                              }
  let(:object)     { klass.new(order, 1)                                         }

  it { should == 1 }
end
