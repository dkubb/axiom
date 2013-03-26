# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#eql?' do
  subject { object.eql?(other) }

  let(:described_class) { Class.new(Function::Proposition) }
  let(:object)          { described_class.new              }

  context 'with the same class' do
    let(:other) { described_class.new }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with a different class' do
    let(:other) { Class.new(Function::Proposition).new }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
