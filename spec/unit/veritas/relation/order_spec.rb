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

    it 'should set the directions' do
      subject.directions.should == @directions
    end
  end

  describe 'with a block' do
    before do
      @block = lambda { |relation| [ relation[:id].asc ] }
    end

    subject { @relation.order(&@block) }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'should set the directions' do
      subject.directions.should == @block.call(@relation)
    end
  end
end
