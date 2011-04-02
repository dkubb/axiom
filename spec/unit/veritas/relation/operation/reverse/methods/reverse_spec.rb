require 'spec_helper'

describe Relation::Operation::Reverse::Methods, '#reverse' do
  subject { object.reverse }

  let(:klass)    { Relation                                               }
  let(:relation) { klass.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }
  let(:object)   { relation.order                                         }

  it { should be_kind_of(Relation::Operation::Reverse) }

  it 'behaves the same as Array#reverse' do
    should == relation.to_a.reverse
  end
end
