require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#optimize' do
  subject { object.optimize }

  let(:klass)      { Relation::Operation::Order               }
  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ].each             }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body) }
  let(:operand)    { relation                                 }
  let(:directions) { [ relation[:id] ]                        }
  let(:object)     { klass.new(operand, directions)           }

  context 'containing a relation' do
    it { should equal(object) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable relation' do
    let(:operand) { relation.project(relation.header) }

    it { should eql(relation.order(directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an object operation' do
    let(:operand) { relation.order { |r| [ r[:id].desc ] } }

    it { should eql(relation.order(directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation' do
    let(:operand) { relation.order.reverse }

    it { should eql(relation.order) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit(1) operation' do
    let(:operand) { relation.order.take(1) }

    it { should equal(operand) }

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
    let(:object)   { klass.new(relation, directions)                             }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
