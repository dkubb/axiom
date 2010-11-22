require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset::Methods#drop' do
  subject { object.drop(offset) }

  let(:klass)    { Relation                                               }
  let(:offset)   { 1                                                      }
  let(:relation) { klass.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }
  let(:object)   { relation.order                                         }

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:to_i) { should == offset }

  it 'behaves the same as Array#drop' do
    should == object.to_a.drop(1)
  end
end
