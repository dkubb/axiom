require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#last' do
  subject { ordered.last(*args) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:ordered)  { relation.order { |r| r[:id] }                               }

  context 'with no arguments' do
    let(:args) { [] }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'returns the expected tuples' do
      should == [ [ 3 ] ]
    end

    it 'behaves the same as Array#last' do
      should == [ ordered.to_a.last ]
    end
  end

  context 'with a limit' do
    let(:args) { [ 2 ] }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'returns the expected tuples' do
      should == [ [ 2 ], [ 3 ] ]
    end

    it 'behaves the same as Array#last' do
      should == ordered.to_a.last(2)
    end
  end
end
