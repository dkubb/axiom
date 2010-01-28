require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#optimize' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ], [ [ 1, 'Dan Kubb', 34 ] ])
  end

  subject { @projection.optimize }

  describe 'when the attributes are equivalent to the relation headers, and in the same order' do
    before do
      @projection = Algebra::Projection.new(@relation, @relation.header)
    end

    it { should equal(@relation) }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @projection
    end
  end

  describe 'when the attributes are equivalent to the relation headers, and not in the same order' do
    before do
      @projection = Algebra::Projection.new(@relation, [ :name, :id ])
    end

    it 'should not factor out the projection, because tuple order is currently significant' do
      should equal(@projection)
    end
  end

  describe 'when the attributes are different from the relation headers' do
    before do
      @projection = Algebra::Projection.new(@relation, [ :id ])
    end

    it { should equal(@projection) }
  end

  describe 'containing an empty relation' do
    before do
      @empty = Relation::Empty.new(@relation.header)

      @projection = Algebra::Projection.new(@empty, [ :id ])
    end

    it { should eql(Relation::Empty.new(@projection.header)) }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @projection
    end
  end

  describe 'containing an empty relation when optimized' do
    before do
      @restriction = Algebra::Restriction.new(@relation, Algebra::Restriction::False.instance)

      @projection = Algebra::Projection.new(@restriction, [ :id ])
    end

    it { should eql(Relation::Empty.new(@projection.header)) }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @projection
    end
  end

  describe 'containing an optimizable relation' do
    before do
      @restriction = Algebra::Restriction.new(@relation, Algebra::Restriction::True.instance)

      @projection = Algebra::Projection.new(@restriction, [ :id ])
    end

    it { should_not equal(@projection) }

    it { should be_instance_of(Algebra::Projection) }

    it { subject.relation.should equal(@relation) }

    it { subject.header.should == @projection.header }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @projection
    end
  end

  describe 'containing a projection' do
    before do
      @other = @relation.project([ :id, :name ])

      @projection = @other.project([ :id ])
    end

    it { should_not equal(@projection) }

    it { should be_instance_of(Algebra::Projection) }

    it { subject.relation.should equal(@relation) }

    it { subject.header.should == @projection.header }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @projection
    end
  end

  describe 'containing a set operation' do
    before do
      @left  = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
      @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
      @union = @left.union(@right)

      @projection = @union.project([ :name ])
    end

    it 'should push the projection to each relation' do
      should eql(Algebra::Union.new(
         Algebra::Projection.new(@left,  @projection.header),
         Algebra::Projection.new(@right, @projection.header)
      ))
    end

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @projection
    end
  end

  describe 'containing a set operation containing a projection' do
    before do
      @left  = Relation.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ], [ [ 1, 'Dan Kubb', 34 ] ])
      @right = Relation.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ], [ [ 2, 'Dan Kubb', 34 ] ])
      @union = @left.project([ :id, :name ]).union(@right.project([ :id, :name ]))

      @projection = @union.project([ :name ])
    end

    it 'should push the projection to each relation, and combine the nested projections' do
      should eql(@left.project([ :name ]).union(@right.project([ :name ])))
    end

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @projection
    end
  end
end
