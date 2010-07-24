require 'spec_helper'

describe 'Veritas::Algebra::Union#optimize' do
  subject { union.optimize }

  let(:header)         { [ [ :id, Integer ] ]             }
  let(:left_body)      { [ [ 1 ] ]                        }
  let(:right_body)     { [ [ 2 ] ]                        }
  let(:original_left)  { Relation.new(header, left_body)  }
  let(:original_right) { Relation.new(header, right_body) }
  let(:union)          { Algebra::Union.new(left, right)  }

  context 'left is an empty relation' do
    let(:left)  { Relation::Empty.new(header) }
    let(:right) { original_right              }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end

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

  context 'right is an empty relation' do
    let(:left)  { original_left               }
    let(:right) { Relation::Empty.new(header) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end

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

  context 'left is an empty relation when optimized' do
    let(:left)  { Algebra::Restriction.new(original_left, Logic::Proposition::False.instance) }
    let(:right) { original_right                                                              }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end

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

  context 'right is an empty relation when optimized' do
    let(:left)  { original_left                                                                }
    let(:right) { Algebra::Restriction.new(original_right, Logic::Proposition::False.instance) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end

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

  context 'left and right are equivalent relations' do
    let(:left_body)  { [ [ 1 ] ].each }
    let(:right_body) { [ [ 1 ] ].each }
    let(:left)       { original_left  }
    let(:right)      { original_right }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
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

  context 'left and right are equivalent materialized relations' do
    let(:left_body)  { [ [ 1 ] ]      }
    let(:right_body) { [ [ 1 ] ]      }
    let(:left)       { original_left  }
    let(:right)      { original_right }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == union
    end

    it 'executes left_body#each' do
      left_body.should_receive(:each)
      subject
    end

    it 'executes right_body#each' do
      right_body.should_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are not empty relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it { should equal(union) }

    it 'executes left_body#each' do
      left_body.should_receive(:each)
      subject
    end

    it 'executes right_body#each' do
      right_body.should_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end
end
