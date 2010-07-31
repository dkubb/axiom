require 'spec_helper'

describe 'Veritas::Algebra::Projection#optimize' do
  subject { projection.optimize }

  let(:header)   { [ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ] }
  let(:body)     { [ [ 1, 'Dan Kubb', 34 ] ]                                  }
  let(:relation) { Relation.new(header, body)                                 }

  context 'when the attributes are equivalent to the relation headers, and in the same order' do
    let(:projection) { Algebra::Projection.new(relation, header) }

    it { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'when the attributes are equivalent to the relation headers, and not in the same order' do
    let(:projection) { Algebra::Projection.new(relation, [ :name, :id ]) }

    it 'does not factor out the projection, because tuple order is currently significant' do
      should equal(projection)
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'when the attributes are different from the relation headers' do
    let(:projection) { Algebra::Projection.new(relation, [ :id ]) }

    it { should equal(projection) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an empty relation' do
    let(:empty)      { Relation::Empty.new(header)             }
    let(:projection) { Algebra::Projection.new(empty, [ :id ]) }

    it { should eql(Relation::Empty.new(projection.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an empty relation when optimized' do
    let(:restriction) { Algebra::Restriction.new(relation, Logic::Proposition::False.instance) }
    let(:projection)  { Algebra::Projection.new(restriction, [ :id ])                          }

    it { should eql(Relation::Empty.new(projection.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable relation' do
    let(:restriction) { Algebra::Restriction.new(relation, Logic::Proposition::True.instance) }
    let(:projection)  { Algebra::Projection.new(restriction, [ :id ])                         }

    it { should_not equal(projection) }

    it { should be_instance_of(Algebra::Projection) }

    its(:operand) { should equal(relation) }

    its(:header) { should == projection.header }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection' do
    let(:other)      { relation.project([ :id, :name ]) }
    let(:projection) { other.project([ :id ])           }

    it { should_not equal(projection) }

    it { should be_instance_of(Algebra::Projection) }

    its(:operand) { should equal(relation) }

    its(:header) { should == projection.header }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
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

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation containing a projection of relations' do
    let(:left_body)  { [ [ 1, 'Dan Kubb', 34 ] ].each                                    }
    let(:right_body) { [ [ 2, 'Dan Kubb', 34 ] ].each                                    }
    let(:left)       { Relation.new(header, left_body)                                   }
    let(:right)      { Relation.new(header, right_body)                                  }
    let(:union)      { left.project([ :id, :name ]).union(right.project([ :id, :name ])) }
    let(:projection) { union.project([ :name ])                                          }

    it 'pushes the projection to each relation, and combine the nested projections' do
      should eql(left.project([ :name ]).union(right.project([ :name ])))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end

    it 'does not execute left_body#each' do
      pending 'TODO: should only compare left and right with #eql? if they are materialized' do
        left_body.should_not_receive(:each)
        subject
      end
    end

    it 'does not execute right_body#each' do
      pending 'TODO: should only compare left and right with #eql? if they are materialized' do
        right_body.should_not_receive(:each)
        subject
      end
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation containing a projection of materialized relations' do
    let(:left_body)  { [ [ 1, 'Dan Kubb', 34 ] ]                                         }
    let(:right_body) { [ [ 2, 'Dan Kubb', 34 ] ]                                         }
    let(:left)       { Relation.new(header, left_body)                                   }
    let(:right)      { Relation.new(header, right_body)                                  }
    let(:union)      { left.project([ :id, :name ]).union(right.project([ :id, :name ])) }
    let(:projection) { union.project([ :name ])                                          }

    it 'pushes the projection to each relation, and combine the nested projections' do
      should eql(left.project([ :name ]).union(right.project([ :name ])))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == projection
    end

    it 'executes left_body#each' do
      pending 'TODO: make sure this is only received once'
      left_body.should_receive(:each)
      subject
    end

    it 'executes right_body#each' do
      pending 'TODO: make sure this is only received once'
      right_body.should_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end
end
