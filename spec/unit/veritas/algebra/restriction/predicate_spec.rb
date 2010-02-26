require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#predicate' do
  subject { @restriction.predicate }

  describe 'when the relation has a True proposition' do
    before do
      @relation  = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
      @predicate = @relation[:id].eq(1)

      @relation.predicate.should == Algebra::Restriction::True.instance

      @restriction = Algebra::Restriction.new(@relation, @predicate)
    end

    it { should equal(@predicate) }
  end

  describe 'when the relation has a False proposition' do
    before do
      @empty = Relation::Empty.new([ [ :id, Integer ] ])
      @predicate = @empty[:id].eq(1)

      @empty.predicate.should == Algebra::Restriction::False.instance

      @restriction = Algebra::Restriction.new(@empty, @predicate)
    end

    it { should == Algebra::Restriction::False.instance }
  end

  describe 'when the relation has a predicate' do
    before do
      @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]).restrict { |r| r[:id].eq(1) }
      @predicate = @relation[:id].ne(0)

      @restriction = Algebra::Restriction.new(@relation, @predicate)
    end

    it { should be_kind_of(Algebra::Restriction::Conjunction) }

    it { should == (@relation.predicate & @predicate) }
  end
end
