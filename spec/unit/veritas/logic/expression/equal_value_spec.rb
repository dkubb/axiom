require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#==' do
  subject { object == other }

  let(:klass) { Class.new(ExpressionSpecs::Object) }

  before do
    klass.class_eval do
      def eql?(other)
        instance_of?(other.class)
      end

      def hash
        object_id
      end
    end
  end

  context 'with two equivalent expressions' do
    let(:object) { klass.new }
    let(:other)  { klass.new }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with two different expressions' do
    let(:object) { klass.new            }
    let(:other)  { Class.new(klass).new }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with two equivalent unoptimized expressions' do
    let(:object) { klass.new & klass.new }
    let(:other)  { klass.new & klass.new }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with two different unoptimized expressions' do
    let(:object)   { klass.new & klass.new       }
    let(:subclass) { Class.new(klass)            }
    let(:other)    { subclass.new & subclass.new }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
