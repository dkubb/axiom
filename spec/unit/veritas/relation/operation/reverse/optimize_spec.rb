require 'spec_helper'

describe 'Veritas::Relation::Operation::Reverse#optimize' do
  subject { reverse.optimize }

  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ]                  }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body) }
  let(:directions) { [ relation[:id] ]                        }
  let(:order)      { relation.order(directions)               }

  context 'with a reverse operation' do
    let(:limit)   { order.limit(2)                          }
    let(:other)   { limit.reverse                           }
    let(:reverse) { Relation::Operation::Reverse.new(other) }

    it 'cancels out the operations and return the contained operation' do
      should equal(limit)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == reverse
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a reverse operation when optimized' do
    let(:limit)      { order.limit(2)                               }
    let(:other)      { limit.reverse                                }
    let(:projection) { other.project(other.header)                  }
    let(:reverse)    { Relation::Operation::Reverse.new(projection) }

    it 'cancels out the operations and return the contained operation' do
      should equal(limit)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == reverse
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an order operation' do
    let(:reverse) { Relation::Operation::Reverse.new(order) }

    it { should eql(relation.order(reverse.directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == reverse
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an order operation when optimized' do
    let(:projection) { order.project(order.header)                  }
    let(:reverse)    { Relation::Operation::Reverse.new(projection) }

    it { should eql(relation.order(reverse.directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == reverse
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizable operation' do
    let(:limit)      { order.limit(2)                               }
    let(:projection) { limit.project(limit.header)                  }
    let(:reverse)    { Relation::Operation::Reverse.new(projection) }

    it { should eql(order.limit(2).reverse) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == reverse
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end
end
