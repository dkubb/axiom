require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit::Methods#take' do
  subject { object.take(limit) }

  let(:klass)    { Relation                                               }
  let(:limit)    { 1                                                      }
  let(:relation) { klass.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }
  let(:object)   { relation.order                                         }

  it { should be_kind_of(Relation::Operation::Limit) }

  its(:to_i) { should == limit }

  it 'behaves the same as Array#take' do
    should == object.to_a.take(limit)
  end
end
