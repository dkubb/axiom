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

    it 'returns an equivalent relation to the unoptimized operation' do
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
      @predicate = @relation[:id].eq(1).and(Algebra::Restriction::True.instance)

      @restriction = Algebra::Restriction.new(@relation, @predicate)
    end

    it { should_not equal(@restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(@relation[:id].eq(1))
    end

    it { subject.relation.should equal(@relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
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

    it 'sets the predicate' do
      subject.predicate.should equal(@predicate)
    end

    it { subject.relation.should equal(@relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with an empty relation' do
    before do
      @empty     = Relation::Empty.new([ [ :id, Integer ] ])
      @predicate = @empty[:id].gte(1)

      @restriction = Algebra::Restriction.new(@empty, @predicate)
    end

    it { should equal(@empty) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with an empty relation when optimized' do
    before do
      @other     = Algebra::Restriction.new(@relation, Algebra::Restriction::False.instance)
      @predicate = @other[:id].gte(1)

      @restriction = Algebra::Restriction.new(@other, @predicate)
    end

    it { should eql(Relation::Empty.new(@relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with a restriction' do
    before do
      @other_predicate = @relation[:id].lt(2)
      @other           = Algebra::Restriction.new(@relation, @other_predicate)
      @predicate       = @relation[:id].gte(1)

      @restriction = Algebra::Restriction.new(@other, @predicate)
    end

    it { should_not equal(@restriction) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(@other_predicate & @predicate)
    end

    it { subject.relation.should equal(@relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with a set operation' do
    before do
      @left      = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
      @right     = Relation.new([ [ :id, Integer ] ], [ [ 2 ] ])
      @union     = @left.union(@right)
      @predicate = @union[:id].gte(1)

      @restriction = Algebra::Restriction.new(@union, @predicate)
    end

    it 'pushes the restriction to each relation' do
      should eql(@left.restrict { |r| r[:id].gte(1) }.union(@right.restrict { |r| r[:id].gte(1) }) )
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with a set operation, containing a restriction with duplicate predicates' do
    before do
      @left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
      @right = Relation.new([ [ :id, Integer ] ], [ [ 2 ] ])
      @union = @left.restrict { |r| r[:id].gte(1) }.union(@right.restrict { |r| r[:id].gte(1) })

      @restriction = @union.restrict { |r| r[:id].gte(1) }
    end

    it 'pushes the restriction to each relation, and then removes duplicate predicates' do
      should eql(@left.restrict { |r| r[:id].gte(1) }.union(@right.restrict { |r| r[:id].gte(1) }) )
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with a reverse operation' do
    before do
      @limit     = @relation.order { |r| r.header }.limit(2)
      @reverse   = @limit.reverse
      @predicate = @reverse[:id].gte(1)

      @restriction = @reverse.restrict(@predicate)
    end

    it 'pushes the restriction under the reverse' do
      should eql(@limit.restrict(@predicate).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with a reverse operation, containing a restriction with duplicate predicates' do
    before do
      @limit     = @relation.order { |r| r.header }.limit(2)
      @reverse   = @limit.restrict { |r| r[:id].gte(1) }.reverse
      @predicate = @reverse[:id].gte(1)

      @restriction = @reverse.restrict(@predicate)
    end

    it 'pushes the restriction under the reverse, and then removes duplicate predicates' do
      should eql(@limit.restrict(@predicate).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with an order operation' do
    before do
      @order     = @relation.order { |r| r.header }
      @predicate = @order[:id].gte(1)

      @restriction = @order.restrict(@predicate)
    end

    it 'pushes the restriction under the order' do
      should eql(@relation.restrict(@predicate).order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end

  describe 'with an order operation, containing a restriction with duplicate predicates' do
    before do
      @order     = @relation.restrict { |r| r[:id].gte(1) }.order { |r| r.header }
      @predicate = @order[:id].gte(1)

      @restriction = @order.restrict(@predicate)
    end

    it 'pushes the restriction under the order, and then removes duplicate predicates' do
      should eql(@relation.restrict(@predicate).order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @restriction
    end
  end
end
