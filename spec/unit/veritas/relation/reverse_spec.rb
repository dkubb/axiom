require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#reverse' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
  end

  describe 'with an ordered relation' do
    before do
      @ordered = @relation.order { |r| r[:id] }
    end

    subject { @ordered.reverse }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'should reverse the direction' do
      subject.directions.should == [ @relation[:id].desc ]
    end
  end

  describe 'without an ordered relation' do
    subject { @relation.reverse }

    it { method(:subject).should raise_error(OrderedRelationRequiredError, 'can only reverse an ordered relation') }
  end
end
