require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#eql?' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @unary_operation = UnaryOperationSpecs::Object.new(@relation)
  end

  subject { @unary_operation.eql?(@other) }

  describe 'with the same unary operation' do
    before do
      @other = @unary_operation
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@unary_operation)
    end
  end

  describe 'with an equivalent unary operation' do
    before do
      @other = @unary_operation.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@unary_operation)
    end
  end

  describe 'with a different unary operation' do
    before do
      @other = UnaryOperationSpecs::Other.new(@relation)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@unary_operation)
    end
  end

  describe 'with an equivalent unary operation of a different class' do
    before do
      klass = Class.new(UnaryOperationSpecs::Object)

      @other = klass.new(@relation)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@unary_operation)
    end
  end
end
