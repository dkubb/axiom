require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#order' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
  end

  describe 'with direction arguments' do
    before do
      @directions = [ @relation[:id].asc ]
    end

    subject { @relation.order(@directions) }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'sets the directions' do
      subject.directions.should == @directions
    end

    it 'behaves the same as Array#sort_by' do
      should == @relation.to_a.sort_by { |tuple| tuple[:id] }
    end
  end

  describe 'with a block' do
    before do
      @block = lambda { |relation| [ relation[:id].asc ] }
    end

    subject { @relation.order(&@block) }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'sets the directions' do
      subject.directions.should == @block.call(@relation)
    end

    it 'behaves the same as Array#sort_by' do
      should == @relation.to_a.sort_by { |tuple| tuple[:id] }
    end
  end
end
