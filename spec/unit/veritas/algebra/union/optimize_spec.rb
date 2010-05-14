require 'spec_helper'

describe 'Veritas::Algebra::Union#optimize' do
  subject { union.optimize }

  let(:header)         { [ [ :id, Integer ] ]            }
  let(:original_left)  { Relation.new(header, [ [ 1 ] ]) }
  let(:original_right) { Relation.new(header, [ [ 2 ] ]) }
  let(:union)          { Algebra::Union.new(left, right) }

  context 'left is an empty relation' do
    let(:left)  { Relation::Empty.new(header) }
    let(:right) { original_right              }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  context 'right is an empty relation' do
    let(:left)  { original_left               }
    let(:right) { Relation::Empty.new(header) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  context 'left is an empty relation when optimized' do
    let(:left)  { Algebra::Restriction.new(original_left, Logic::Proposition::False.instance) }
    let(:right) { original_right                                                              }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  context 'right is an empty relation when optimized' do
    let(:left)  { original_left                                                                }
    let(:right) { Algebra::Restriction.new(original_right, Logic::Proposition::False.instance) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end

  context 'left and right are not empty relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it { should equal(union) }
  end

  context 'left and right are equivalent relations' do
    let(:left)  { original_left }
    let(:right) { left.dup      }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end
  end
end
