require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#==' do
  before :all do
    ExpressionSpecs::Object.class_eval do
      def eql?(other)
        instance_of?(other.class)
      end
    end
  end

  subject { @expression == @other }

  describe 'with two equivalent expressions' do
    before do
      @expression = ExpressionSpecs::Object.new
      @other      = ExpressionSpecs::Object.new
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@expression)
    end
  end

  describe 'with two different expressions' do
    before do
      subclass = Class.new(ExpressionSpecs::Object)

      @expression = ExpressionSpecs::Object.new
      @other      = subclass.new
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@expression)
    end
  end

  describe 'with two equivalent unoptimized expressions' do
    before do
      @expression = ExpressionSpecs::Object.new & ExpressionSpecs::Object.new
      @other      = ExpressionSpecs::Object.new & ExpressionSpecs::Object.new
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@expression)
    end
  end

  describe 'with two different unoptimized expressions' do
    before do
      subclass = Class.new(ExpressionSpecs::Object)

      @expression = ExpressionSpecs::Object.new & ExpressionSpecs::Object.new
      @other      = subclass.new & subclass.new
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@expression)
    end
  end
end
