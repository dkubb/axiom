require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Difference#optimize' do
  let(:header)         { [ [ :id, Integer ] ]                 }
  let(:original_left)  { Relation.new(header, [ [ 1 ] ])      }
  let(:original_right) { Relation.new(header, [ [ 2 ] ])      }
  let(:difference)     { Algebra::Difference.new(left, right) }

  subject { difference.optimize }

  context 'left is an empty relation' do
    let(:left)  { Relation::Empty.new(header) }
    let(:right) { original_right              }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == difference
    end
  end

  context 'right is an empty relation' do
    let(:left)  { original_left               }
    let(:right) { Relation::Empty.new(header) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == difference
    end
  end

  context 'left is an empty relation when optimized' do
    let(:left)  { Algebra::Restriction.new(original_left, Logic::Proposition::False.instance) }
    let(:right) { original_right                                                              }

    it { should eql(Relation::Empty.new(left.header | right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == difference
    end
  end

  context 'right is an empty relation when optimized' do
    let(:left)  { original_left                                                                }
    let(:right) { Algebra::Restriction.new(original_right, Logic::Proposition::False.instance) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == difference
    end
  end

  context 'left and right are not empty relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it { should equal(difference) }
  end

  context 'left and right are equivalent relations' do
    let(:left)  { original_left }
    let(:right) { left.dup      }

    it { should eql(Relation::Empty.new(header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == difference
    end
  end
end
