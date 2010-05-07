require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#optimize' do
  let(:left)  { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
  let(:right) { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }

  subject { product.optimize }

  context 'left is a TABLE_DUM' do
    let(:product) { Algebra::Product.new(TABLE_DUM, right) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'right is a TABLE_DUM' do
    let(:product) { Algebra::Product.new(left, TABLE_DUM) }

    it { should eql(Relation::Empty.new(left.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'left is a TABLE_DUM when optimized' do
    let(:product) { Algebra::Product.new(TABLE_DUM.project([]), right) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'right is a TABLE_DUM when optimized' do
    let(:product) { Algebra::Product.new(left, TABLE_DUM.project([])) }

    it { should eql(Relation::Empty.new(left.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'left is a TABLE_DEE' do
    let(:product) { Algebra::Product.new(TABLE_DEE, right) }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'right is a TABLE_DEE' do
    let(:product) { Algebra::Product.new(left, TABLE_DEE) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'left is a TABLE_DEE when optimized' do
    let(:product) { Algebra::Product.new(TABLE_DEE.project([]), right) }

    it { should equal(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'right is a TABLE_DEE when optimized' do
    let(:product) { Algebra::Product.new(left, TABLE_DEE.project([])) }

    it { should equal(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == product
    end
  end

  context 'left and right are normal relations' do
    let(:product) { Algebra::Product.new(left, right) }

    it { should equal(product) }
  end
end
