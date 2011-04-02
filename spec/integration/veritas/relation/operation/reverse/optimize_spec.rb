require 'spec_helper'

describe Relation::Operation::Reverse, '#optimize' do
  subject { object.optimize }

  let(:klass)      { Relation::Operation::Reverse             }
  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ].each             }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body) }
  let(:order)      { relation.order                           }
  let(:operand)    { order                                    }
  let(:object)     { klass.new(operand)                       }

  context 'with a object operation' do
    let(:limit)   { order.take(2) }
    let(:operand) { limit.reverse }

    it 'cancels out the operations and return the contained operation' do
      should equal(limit)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a object operation when optimized' do
    let(:limit)   { order.take(2)                       }
    let(:operand) { limit.reverse.rename({}) }

    it 'cancels out the operations and return the contained operation' do
      should equal(limit)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an order operation' do
    it { should eql(relation.order(object.directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an order operation when optimized' do
    let(:operand) { order.rename({}) }

    it { should eql(relation.order(object.directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizable operation' do
    let(:limit)   { order.take(2)    }
    let(:operand) { limit.rename({}) }

    it { should eql(order.take(2).reverse) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a materialized relation' do
    let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ] ], [ [ 3 ], [ 2 ], [ 1 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
