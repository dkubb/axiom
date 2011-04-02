require 'spec_helper'

describe Relation::Operation::Offset, '#optimize' do
  subject { object.optimize }

  let(:klass)      { Relation::Operation::Offset              }
  let(:body)       { [ [ 1 ], [ 2 ], [ 3 ] ].each             }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], body) }
  let(:directions) { [ relation[:id] ]                        }
  let(:order)      { relation.order(directions)               }
  let(:operand)    { order                                    }
  let(:offset)     { 1                                        }
  let(:object)     { klass.new(operand, offset)               }

  context 'with an object of 0' do
    let(:offset) { 0 }

    it { should equal(order) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation' do
    it { should equal(object) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable order operation' do
    let(:operand) { order.rename({}) }

    it { should be_kind_of(klass) }

    its(:operand) { should equal(order) }

    its(:offset) { should == 1 }

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
    let(:operand) { order.drop(5) }
    let(:offset)  { 10            }

    it { should be_kind_of(klass) }

    its(:operand) { should equal(order) }

    it 'adds the object of the operations' do
      subject.offset.should == 15
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

  context 'containing a materialized relation' do
    let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ] ], [ [ 2 ], [ 3 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
