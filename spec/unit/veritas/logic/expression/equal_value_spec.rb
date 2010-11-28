require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#==' do
  subject { object == other }

  let(:klass)  { Class.new(ExpressionSpecs::Object) }
  let(:object) { klass.new                          }

  before do
    klass.class_eval do
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
    let(:object) { klass.new & klass.new }
    let(:other)  { klass.new & klass.new }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with two different unoptimized object' do
    let(:object)   { klass.new & klass.new       }
    let(:subclass) { Class.new(klass)            }
    let(:other)    { subclass.new & subclass.new }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
