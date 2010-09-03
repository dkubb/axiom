require 'spec_helper'

describe 'Veritas::Algebra::Join#optimize' do
  subject { object.optimize }

  let(:klass)          { Algebra::Join                                                     }
  let(:left_body)      { [ [ 1 ], [ 2 ] ].each                                             }
  let(:right_body)     { [ [ 2, 'Dan Kubb' ] ].each                                        }
  let(:original_left)  { Relation.new([ [ :id, Integer ] ],                    left_body)  }
  let(:original_right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], right_body) }
  let(:left)           { original_left                                                     }
  let(:right)          { original_right                                                    }
  let(:object)         { klass.new(left, right)                                            }

  context 'left is an empty relation' do
    let(:left) { Relation::Empty.new(original_left.header) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is an empty relation' do
    let(:right) { Relation::Empty.new(original_right.header) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is an empty relation when optimized' do
    let(:left) { Algebra::Restriction.new(original_left, Logic::Proposition::False.instance) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is an empty relation when optimized' do
    let(:right) { Algebra::Restriction.new(original_right, Logic::Proposition::False.instance) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are not empty relations' do
    it { should equal(object) }

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are materialized relations' do
    let(:left)  { Relation.new([ [ :id, Integer ] ],                    [ [ 1 ], [ 2 ] ])      }
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
