require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#sort_tuples' do
  subject { directions.sort_tuples(relation) }

  let(:relation) do
    Relation.new(
      [ [ :id, Integer ], [ :name, String ] ],
      [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ] ]
    )
  end

  let(:directions) { Relation::Operation::Order::DirectionSet.new(relation.header) }

  context 'sorted with ascending id and descending name' do
    let(:directions) do
      Relation::Operation::Order::DirectionSet.new(
        [ relation[:id].asc, relation[:name].desc ]
      )
    end

    it { should be_kind_of(Array) }

    it { should == [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ] }
  end

  context 'sorted with ascending id and ascending name' do
    let(:directions) do
      Relation::Operation::Order::DirectionSet.new(
        [ relation[:id].asc, relation[:name].asc ]
      )
    end

    it { should be_kind_of(Array) }

    it { should == [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ] ] }
  end

  context 'sorted with descending id and ascending name' do
    let(:directions) do
      Relation::Operation::Order::DirectionSet.new(
        [ relation[:id].desc, relation[:name].asc ]
      )
    end

    it { should be_kind_of(Array) }

    it { should == [ [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ], [ 1, 'Dan Kubb' ] ] }
  end

  context 'sorted with descending id and descending name' do
    let(:directions) do
      Relation::Operation::Order::DirectionSet.new(
        [ relation[:id].desc, relation[:name].desc ]
      )
    end

    it { should be_kind_of(Array) }

    it { should == [ [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 1, 'Dan Kubb' ] ] }
  end
end
