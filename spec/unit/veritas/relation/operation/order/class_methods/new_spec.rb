require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order.new' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
  end

  subject { Relation::Operation::Order.new(@relation, @directions) }

  describe 'with all attributes specified in the directions' do
    before do
      @directions = [ @relation[:id] ]
    end

    it 'sets the relation' do
      subject.relation.should equal(@relation)
    end

    it 'sets the directions' do
      subject.directions.should == [ @relation[:id].asc ]
    end
  end

  describe 'without all attributes specified in the directions' do
    before do
      @directions = []
    end

    it { method(:subject).should raise_error(ArgumentError, 'directions must include every attribute in the header') }
  end
end
