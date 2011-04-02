require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Expression, '#==' do
  subject { object == other }

  let(:described_class) { Class.new(ExpressionSpecs::Object) }
  let(:object)          { described_class.new                }

  before do
    described_class.class_eval do
      def eql?(other)
        instance_of?(other.class)
      end
    end
  end

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with two equivalent unoptimized object' do
    let(:object) { described_class.new & described_class.new }
    let(:other)  { described_class.new & described_class.new }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with two different unoptimized object' do
    let(:object)   { described_class.new & described_class.new }
    let(:subclass) { Class.new(described_class)                }
    let(:other)    { subclass.new & subclass.new               }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
