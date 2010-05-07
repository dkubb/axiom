require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#==' do
  subject { expression == other }

  before :all do
    ExpressionSpecs::Object.class_eval do
      def eql?(other)
        instance_of?(other.class)
      end
    end
  end

  context 'with two equivalent expressions' do
    let(:expression) { ExpressionSpecs::Object.new }
    let(:other)      { ExpressionSpecs::Object.new }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(expression)
    end
  end

  context 'with two different expressions' do
    let(:expression) { ExpressionSpecs::Object.new            }
    let(:other)      { Class.new(ExpressionSpecs::Object).new }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(expression)
    end
  end

  context 'with two equivalent unoptimized expressions' do
    let(:expression) { ExpressionSpecs::Object.new & ExpressionSpecs::Object.new }
    let(:other)      { ExpressionSpecs::Object.new & ExpressionSpecs::Object.new }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(expression)
    end
  end

  context 'with two different unoptimized expressions' do
    let(:expression) { ExpressionSpecs::Object.new & ExpressionSpecs::Object.new }
    let(:subclass)   { Class.new(ExpressionSpecs::Object)                        }
    let(:other)      { subclass.new & subclass.new                               }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(expression)
    end
  end
end
