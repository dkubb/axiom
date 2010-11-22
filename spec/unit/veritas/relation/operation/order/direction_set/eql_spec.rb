require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#eql?' do
  subject { object.eql?(other) }

  let(:klass)     { Relation::Operation::Order::DirectionSet }
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:object)    { klass.new([ attribute ])                 }

  context 'with the same directions' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with equivalent directions' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with different directions' do
    let(:other) { klass.new([ attribute.desc ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with equivalent directions of a different class' do
    let(:other) { Class.new(klass).new([ attribute ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
