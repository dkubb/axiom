require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset.new' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
  end

  subject { Relation::Operation::Offset.new(@relation, 1) }

  describe 'with an ordered relation' do
    before do
      @relation = @relation.order { |r| r[:id] }
    end

    it { should be_kind_of(Relation::Operation::Offset)  }
  end

  describe 'without an ordered relation' do
    it { method(:subject).should raise_error(OrderedRelationRequiredError, 'can only offset an ordered relation') }
  end

  describe 'with an offset less than 0' do
    before do
      @relation = @relation.order { |r| r[:id] }
    end

    subject { Relation::Operation::Offset.new(@relation, -1) }

    it { method(:subject).should raise_error(InvalidOffsetError, 'offset must be greater than or equal to 0, but was -1') }
  end
end
