require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#eql?' do
  subject { object.eql?(other) }

  let(:klass)      { Relation::Operation::Order::DirectionSet }
  let(:attributes) { [ Attribute::Integer.new(:id) ]          }
  let(:object)     { klass.new(attributes)                    }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with equivalent object of a subclass' do
    let(:other) { Class.new(klass).new(attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having different attributes' do
    let(:other_attributes) { [ Attribute::Integer.new(:other_id) ] }
    let(:other)            { klass.new(other_attributes)           }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
