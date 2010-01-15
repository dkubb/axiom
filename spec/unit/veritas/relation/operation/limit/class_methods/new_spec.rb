require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit.new' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
  end

  subject { Relation::Operation::Limit.new(@relation, 1) }

  describe 'with an ordered relation' do
    before do
      @relation = @relation.order { |r| r[:id] }
    end

    it { should be_kind_of(Relation::Operation::Limit)  }
  end

  describe 'without an ordered relation' do
    it { method(:subject).should raise_error(OrderedRelationRequiredError, 'can only limit an ordered relation') }
  end
end
