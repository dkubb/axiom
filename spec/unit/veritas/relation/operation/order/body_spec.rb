require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#body' do
  before do
    @relation = Relation.new(
      [ [ :id, Integer ], [ :name, String ] ],
      [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ] ]
    )
  end

  subject { @order.body }

  describe 'sorted with ascending id and descending name' do
    before do
      @direction = [ @relation[:id].asc, @relation[:name].desc ]
      @order     = Relation::Operation::Order.new(@relation, @direction)
    end

    it { should be_kind_of(Relation::Operation::Order::Body) }

    it { should == [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ] }
  end

  describe 'sorted with ascending id and ascending name' do
    before do
      @direction = [ @relation[:id].asc, @relation[:name].asc ]
      @order     = Relation::Operation::Order.new(@relation, @direction)
    end

    it { should be_kind_of(Relation::Operation::Order::Body) }

    it { should == [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ] ] }
  end

  describe 'sorted with descending id and ascending name' do
    before do
      @direction = [ @relation[:id].desc, @relation[:name].asc ]
      @order     = Relation::Operation::Order.new(@relation, @direction)
    end

    it { should be_kind_of(Relation::Operation::Order::Body) }

    it { should == [ [ 2, 'Alex Kubb' ], [ 2, 'Dan Kubb' ], [ 1, 'Dan Kubb' ] ] }
  end

  describe 'sorted with descending id and descending name' do
    before do
      @direction = [ @relation[:id].desc, @relation[:name].desc ]
      @order     = Relation::Operation::Order.new(@relation, @direction)
    end

    it { should be_kind_of(Relation::Operation::Order::Body) }

    it { should == [ [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ], [ 1, 'Dan Kubb' ] ] }
  end
end
