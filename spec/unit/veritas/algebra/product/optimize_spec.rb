require 'spec_helper'

describe 'Veritas::Algebra::Product#optimize' do
  subject { product.optimize }

  let(:left_body)  { [ [ 1 ] ]          }
  let(:right_body) { [ [ 'Dan Kubb' ] ] }

  let(:left)  { Relation.new([ [ :id,   Integer ] ], left_body)  }
  let(:right) { Relation.new([ [ :name, String  ] ], right_body) }

  context 'left is a TABLE_DUM' do
    let(:product) { Algebra::Product.new(TABLE_DUM, right) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DUM' do
    let(:product) { Algebra::Product.new(left, TABLE_DUM) }

    it { should eql(Relation::Empty.new(left.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is a TABLE_DUM when optimized' do
    let(:product) { Algebra::Product.new(TABLE_DUM.project([]), right) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DUM when optimized' do
    let(:product) { Algebra::Product.new(left, TABLE_DUM.project([])) }

    it { should eql(Relation::Empty.new(left.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is a TABLE_DEE' do
    let(:product) { Algebra::Product.new(TABLE_DEE, right) }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DEE' do
    let(:product) { Algebra::Product.new(left, TABLE_DEE) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is a TABLE_DEE when optimized' do
    let(:product) { Algebra::Product.new(TABLE_DEE.project([]), right) }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DEE when optimized' do
    let(:product) { Algebra::Product.new(left, TABLE_DEE.project([])) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are normal relations' do
    let(:product) { Algebra::Product.new(left, right) }

    it { should equal(product) }

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
end
