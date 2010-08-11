require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#optimize' do
  subject { offset.optimize }

  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ].each                         }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body)             }
  let(:directions) { [ relation[:id] ]                                    }
  let(:order)      { Relation::Operation::Order.new(relation, directions) }

  context 'with an offset of 0' do
    let(:offset) { order.offset(0) }

    it { should equal(order) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == offset
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation' do
    let(:offset) { Relation::Operation::Offset.new(order, 1) }

    it { should equal(offset) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable order operation' do
    let(:projection) { order.project(order.header)                    }
    let(:offset)     { Relation::Operation::Offset.new(projection, 1) }

    it { should be_instance_of(Relation::Operation::Offset) }

    its(:operand) { should equal(order) }

    its(:to_i) { should == 1 }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == offset
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an offset operation' do
    let(:original) { Relation::Operation::Offset.new(order,     5) }
    let(:offset)   { Relation::Operation::Offset.new(original, 10) }

    it { should be_instance_of(Relation::Operation::Offset) }

    its(:operand) { should equal(order) }

    it 'adds the offset of the operations' do
      subject.to_i.should == 15
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == offset
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a materialized relation' do
    let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
    let(:order)    { Relation::Operation::Order.new(relation, directions)        }
    let(:offset)   { order.offset(1)                                             }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ] ], [ [ 2 ], [ 3 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == offset
    end

    it_should_behave_like 'an optimize method'
  end
end
