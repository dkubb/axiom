require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#optimize' do
  subject { projection.optimize }

  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ], [ [ 1, 'Dan Kubb', 34 ] ]) }

  context 'when the attributes are equivalent to the relation headers, and in the same order' do
    let(:projection) { Algebra::Projection.new(relation, relation.header) }

    it { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end
  end

  context 'when the attributes are equivalent to the relation headers, and not in the same order' do
    let(:projection) { Algebra::Projection.new(relation, [ :name, :id ]) }

    it 'does not factor out the projection, because tuple order is currently significant' do
      should equal(projection)
    end
  end

  context 'when the attributes are different from the relation headers' do
    let(:projection) { Algebra::Projection.new(relation, [ :id ]) }

    it { should equal(projection) }
  end

  context 'containing an empty relation' do
    let(:empty)      { Relation::Empty.new(relation.header)    }
    let(:projection) { Algebra::Projection.new(empty, [ :id ]) }

    it { should eql(Relation::Empty.new(projection.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end
  end

  context 'containing an empty relation when optimized' do
    let(:restriction) { Algebra::Restriction.new(relation, Logic::Proposition::False.instance) }
    let(:projection)  { Algebra::Projection.new(restriction, [ :id ])                          }

    it { should eql(Relation::Empty.new(projection.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end
  end

  context 'containing an optimizable relation' do
    let(:restriction) { Algebra::Restriction.new(relation, Logic::Proposition::True.instance) }
    let(:projection)  { Algebra::Projection.new(restriction, [ :id ])                         }

    it { should_not equal(projection) }

    it { should be_instance_of(Algebra::Projection) }

    its(:relation) { should equal(relation) }

    its(:header) { should == projection.header }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end
  end

  context 'containing a projection' do
    let(:other)      { relation.project([ :id, :name ]) }
    let(:projection) { other.project([ :id ])           }

    it { should_not equal(projection) }

    it { should be_instance_of(Algebra::Projection) }

    its(:relation) { should equal(relation) }

    its(:header) { should == projection.header }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end
  end

  context 'containing a set operation' do
    let(:left)       { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }
    let(:right)      { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }
    let(:union)      { left.union(right)                                                            }
    let(:projection) { union.project([ :name ])                                                     }

    it 'pushes the projection to each relation' do
      should eql(Algebra::Union.new(
         Algebra::Projection.new(left,  projection.header),
         Algebra::Projection.new(right, projection.header)
      ))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end
  end

  context 'containing a set operation containing a projection' do
    let(:left)       { Relation.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ], [ [ 1, 'Dan Kubb', 34 ] ]) }
    let(:right)      { Relation.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ], [ [ 2, 'Dan Kubb', 34 ] ]) }
    let(:union)      { left.project([ :id, :name ]).union(right.project([ :id, :name ]))                                   }
    let(:projection) { union.project([ :name ])                                                                            }

    it 'pushes the projection to each relation, and combine the nested projections' do
      should eql(left.project([ :name ]).union(right.project([ :name ])))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end
  end
end
