require 'spec_helper'

describe Algebra::Difference, '#optimize' do
  subject { object.optimize }

  let(:klass)          { Algebra::Difference              }
  let(:header)         { [ [ :id, Integer ] ]             }
  let(:left_body)      { [ [ 1 ] ].each                   }
  let(:right_body)     { [ [ 2 ] ].each                   }
  let(:original_left)  { Relation.new(header, left_body)  }
  let(:original_right) { Relation.new(header, right_body) }
  let(:object)         { klass.new(left, right)           }

  context 'left is an empty relation' do
    let(:left)  { Relation::Empty.new(header) }
    let(:right) { original_right              }

    it { should equal(left) }

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
    let(:left)  { original_left               }
    let(:right) { Relation::Empty.new(header) }

    it { should equal(left) }

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
    let(:left)  { Algebra::Restriction.new(original_left, Logic::Proposition::False.instance) }
    let(:right) { original_right                                                              }

    it { should eql(Relation::Empty.new(left.header | right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
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
      should == object
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

  unless defined?(JRUBY_VERSION) && JRUBY_VERSION < '1.6'
    context 'left and right are equivalent relations' do
      let(:right_body) { left_body.dup  }
      let(:left)       { original_left  }
      let(:right)      { original_right }

      it { should eql(Relation::Empty.new(header)) }

      it 'returns an equivalent relation to the unoptimized operation' do
        should == object
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
  end

  context 'left and right are not empty relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it { should equal(object) }

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

  context 'left and right are materialized relations' do
    let(:left)  { Relation.new(header, [ [ 1 ], [ 2 ] ]) }
    let(:right) { Relation.new(header, [ [ 1 ] ])        }

    it { should eql(Relation::Materialized.new(header, [ [ 2 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
