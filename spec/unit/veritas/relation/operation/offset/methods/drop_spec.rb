require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset::Methods#drop' do
  subject { ordered.drop(1) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:ordered)  { relation.order { |r| r[:id] }                        }

  it { should be_kind_of(Relation::Operation::Offset) }

  it 'behaves the same as Array#drop' do
    should == ordered.to_a.drop(1)
  end
end
