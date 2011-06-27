# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#eql?' do
  subject { object.eql?(other) }

  let(:attributes) { [ Attribute::Integer.new(:id) ] }
  let(:object)     { described_class.new(attributes) }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having different attributes' do
    let(:other_attributes) { [ Attribute::Integer.new(:other_id) ] }
    let(:other)            { described_class.new(other_attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
