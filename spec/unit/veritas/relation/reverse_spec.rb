require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#reverse' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:ordered)  { relation.order { |r| r[:id] }                        }

  subject { ordered.reverse }

  it { should be_kind_of(Relation::Operation::Reverse) }

  it 'behaves the same as Array#reverse' do
    should == relation.to_a.reverse
  end
end
