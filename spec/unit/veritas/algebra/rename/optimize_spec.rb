require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#optimize' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
    @aliases  = { :id => :other_id }
  end

  subject { @rename.optimize }

  describe 'containing a relation' do
    before do
      @rename = Algebra::Rename.new(@relation, @aliases)
    end

    it { should equal(@rename) }
  end

  describe 'containing an empty relation' do
    before do
      @empty = Relation::Empty.new(@relation.header)

      @rename = Algebra::Rename.new(@empty, @aliases)
    end

    it { should eql(Relation::Empty.new(@rename.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an optimizable relation' do
    before do
      @projection = @relation.project(@relation.header)

      @rename = Algebra::Rename.new(@projection, @aliases)
    end

    it { should_not equal(@rename) }

    it { should be_instance_of(Algebra::Rename) }

    it 'sets aliases the same as the original rename' do
      subject.aliases.should == @rename.aliases
    end

    its(:relation) { should equal(@relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a rename operation' do
    before do
      @rename = Algebra::Rename.new(@relation, :id   => :other_id)
      @rename = Algebra::Rename.new(@rename,   :name => :other_name)
    end

    it { should_not equal(@rename) }

    it { should be_instance_of(Algebra::Rename) }

    it 'sets aliases as a union of both aliases' do
      subject.aliases.should == @aliases.merge(:name => :other_name)
    end

    its(:relation) { should equal(@relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a rename operation with overlapping aliases' do
    before do
      @rename = Algebra::Rename.new(@relation, :id       => :other_id)
      @rename = Algebra::Rename.new(@rename,   :other_id => :another_id)
    end

    it { should_not equal(@rename) }

    it { should be_instance_of(Algebra::Rename) }

    it 'sets aliases as a union of both aliases' do
      subject.aliases.should == { :id => :another_id }
    end

    its(:relation) { should equal(@relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an inverse rename operation' do
    before do
      @rename = Algebra::Rename.new(@relation, :id       => :other_id)
      @rename = Algebra::Rename.new(@rename,   :other_id => :id)
    end

    it { should equal(@relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a projection' do
    before do
      @projection = @relation.project([ :id ])

      @rename = Algebra::Rename.new(@projection, @aliases)
    end

    it { should be_instance_of(Algebra::Projection) }

    its(:relation) { should eql(Algebra::Rename.new(@relation, @aliases)) }

    its(:header) { should == [ [ :other_id, Integer ] ] }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a projection, containing a rename that cancels out' do
    before do
      @projection = @relation.rename(:id => :other_id).project([ :other_id ])

      @rename = Algebra::Rename.new(@projection, :other_id => :id)
    end

    it 'pushes the rename before the projection, and then cancel it out' do
      should eql(@relation.project([ :id ]))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a restriction' do
    before do
      @restriction = @relation.restrict { |r| r[:id].eq(1) }

      @rename = Algebra::Rename.new(@restriction, @aliases)
    end

    it { should be_instance_of(Algebra::Restriction) }

    its(:relation) { should eql(Algebra::Rename.new(@relation, @aliases)) }

    its(:header) { should == [ [ :other_id, Integer ], [ :name, String ] ] }

    its(:predicate) { should == @rename[:other_id].eq(1) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a restriction, containing a rename that cancels out' do
    before do
      @projection = @relation.rename(:id => :other_id).restrict { |r| r[:other_id].eq(1) }

      @rename = Algebra::Rename.new(@projection, :other_id => :id)
    end

    it 'pushes the rename before the restriction, and then cancel it out' do
      should eql(@relation.restrict { |r| r[:id].eq(1) })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a set operation' do
    before do
      @left  = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
      @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
      @union = @left.union(@right)

      @rename = @union.rename(@aliases)
    end

    it 'pushes the rename to each relation' do
      should eql(@left.rename(@aliases).union(@right.rename(@aliases)))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a set operation, containing a rename that cancels out' do
    before do
      @left  = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
      @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
      @union = @left.rename(:id => :other_id).union(@right.rename(:id => :other_id))

      @rename = @union.rename(:other_id => :id)
    end

    it 'pushes the rename to each relation, then cancel it out' do
      should eql(@left.union(@right))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a reverse operation' do
    before do
      @limit   = @relation.order { |r| r.header }.limit(2)
      @reverse = @limit.reverse

      @rename = @reverse.rename(@aliases)
    end

    it 'pushes the rename under the order, limit and reverse' do
      should eql(@relation.rename(@aliases).order { |r| r.header }.limit(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a reverse operation, containing a rename that cancels out' do
    before do
      @limit   = @relation.order { |r| r.header }.limit(2)
      @reverse = @limit.rename(:id => :other_id).reverse

      @rename = @reverse.rename(:other_id => :id)
    end

    it 'pushes the rename under the order, limit and reverse, and then cancel it out' do
      should eql(@relation.order { |r| r.header }.limit(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an order operation' do
    before do
      @order = @relation.order { |r| r.header }

      @rename = @order.rename(@aliases)
    end

    it 'pushes the rename under the order' do
      should eql(@relation.rename(@aliases).order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an order operation, containing a rename that cancels out' do
    before do
      @order = @relation.rename(:id => :other_id).order { |r| r.header }

      @rename = @order.rename(:other_id => :id)
    end

    it 'pushes the rename under the order, and then cancel it out' do
      should eql(@relation.order { |r| r.header })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a limit operation' do
    before do
      @order = @relation.order { |r| r.header }
      @limit = @order.limit(2)

      @rename = @limit.rename(@aliases)
    end

    it 'pushes the rename under the limit and order' do
      should eql(@relation.rename(@aliases).order { |r| r.header }.limit(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing a limit operation, containing a rename that cancels out' do
    before do
      @order = @relation.order { |r| r.header }
      @limit = @order.rename(:id => :other_id).limit(2)

      @rename = @limit.rename(:other_id => :id)
    end

    it 'pushes the rename under the limit and order, and then cancel it out' do
      should eql(@relation.order { |r| r.header }.limit(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an offset operation' do
    before do
      @order = @relation.order { |r| r.header }
      @offset = @order.offset(1)

      @rename = @offset.rename(@aliases)
    end

    it 'pushes the rename under the offset and order' do
      should eql(@relation.rename(@aliases).order { |r| r.header }.offset(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end

  describe 'containing an offset operation, containing a rename that cancels out' do
    before do
      @order = @relation.order { |r| r.header }
      @offset = @order.rename(:id => :other_id).offset(1)

      @rename = @offset.rename(:other_id => :id)
    end

    it 'pushes the rename under the offset and order, and then cancel it out' do
      should eql(@relation.order { |r| r.header }.offset(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @rename
    end
  end
end
