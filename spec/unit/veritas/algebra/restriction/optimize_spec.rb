require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#optimize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @restriction.optimize }

  describe 'with a true proposition' do
    before do
      @proposition = @relation[:id].eq(@relation[:id])

      @restriction = Algebra::Restriction.new(@relation, @proposition)
    end

    it { should equal(@relation) }
  end

  describe 'with a false proposition' do
    before do
      @proposition = @relation[:id].ne(@relation[:id])

      @restriction = Algebra::Restriction.new(@relation, @proposition)
    end

    it { should eql(Relation::Empty.new(@relation.header)) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with a predicate' do
    before do
      @predicate = @relation[:id].eq(1)

      @restriction = Algebra::Restriction.new(@relation, @predicate)
    end

    it { should equal(@restriction) }
  end

  describe 'with an optimizable predicate' do
    before do
      @predicate = @relation[:id].eq(1).and(Algebra::Restriction::True.new)

      @restriction = Algebra::Restriction.new(@relation, @predicate)
    end

    it { should_not equal(@restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'should set the predicate' do
      subject.predicate.should eql(@relation[:id].eq(1))
    end

    it { subject.relation.should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with an optimizable operation' do
    before do
      @predicate  = @relation[:id].eq(1)
      @projection = @relation.project(@relation.header)

      @restriction = Algebra::Restriction.new(@projection, @predicate)
    end

    it { should_not equal(@restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'should set the predicate' do
      subject.predicate.should equal(@predicate)
    end

    it { subject.relation.should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with an empty relation' do
    before do
      @empty     = Relation::Empty.new([ [ :id, Integer ] ])
      @predicate = @empty.header[:id].gte(1)

      @restriction = Algebra::Restriction.new(@empty, @predicate)
    end

    it { should equal(@empty) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with an empty relation when optimized' do
    before do
      @other     = Algebra::Restriction.new(@relation, Algebra::Restriction::False.new)
      @predicate = @other.header[:id].gte(1)

      @restriction = Algebra::Restriction.new(@other, @predicate)
    end

    it { should eql(Relation::Empty.new(@relation.header)) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with a restriction' do
    before do
      @other_predicate = @relation.header[:id].lt(2)
      @other           = Algebra::Restriction.new(@relation, @other_predicate)
      @predicate       = @relation.header[:id].gte(1)

      @restriction = Algebra::Restriction.new(@other, @predicate)
    end

    it { should_not equal(@restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'should set the predicate' do
      subject.predicate.should eql(@other_predicate & @predicate)
    end

    it { subject.relation.should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @restriction
    end
  end
end
