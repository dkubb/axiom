require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit#optimize' do
  subject { limit.optimize }

  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ]                              }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body)             }
  let(:directions) { [ relation[:id] ]                                    }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }

  context 'when the limit is 0' do
    let(:limit) { order.limit(0) }

    it { should be_kind_of(Relation::Empty) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == limit
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation' do
    let(:limit) { Relation::Operation::Limit.new(order, 1) }

    it { should equal(limit) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable order operation' do
    let(:projection) { order.project(order.header)                   }
    let(:limit)      { Relation::Operation::Limit.new(projection, 1) }

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:relation) { should equal(order) }

    its(:to_i) { should == 1 }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == limit
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a more restrictive limit operation' do
    let(:limit) do
      limit = Relation::Operation::Limit.new(order, 5)
      Relation::Operation::Limit.new(limit, 10)
    end

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:relation) { should equal(order) }

    it 'uses the more restrictive limit' do
      subject.to_i.should == 5
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == limit
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a less restrictive limit operation' do
    let(:original) { Relation::Operation::Limit.new(order,    10) }
    let(:limit)    { Relation::Operation::Limit.new(original,  5) }

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:relation) { should equal(order) }

    it 'uses the more restrictive limit' do
      subject.to_i.should == 5
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == limit
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a similar limit operation' do
    let(:original) { Relation::Operation::Limit.new(order,    10) }
    let(:limit)    { Relation::Operation::Limit.new(original, 10) }

    it { should equal(original) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == limit
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end
end
