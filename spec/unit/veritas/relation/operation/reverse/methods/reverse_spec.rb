require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Reverse::Methods#reverse' do
  subject { ordered.reverse }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:ordered)  { relation.order { |r| r[:id] }                        }

  it { should be_kind_of(Relation::Operation::Reverse) }

  it 'behaves the same as Array#reverse' do
    should == relation.to_a.reverse
  end
end
