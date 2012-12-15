# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#add' do
  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:header)    { Relation::Header.new([ attribute ]) }

  context 'when an aggregate is provided' do
    subject { described_class.new(header) { |object| object.add(:aggregate, aggregate) } }

    let(:aggregate) { attribute.sum }

    its(:functions) { should eql(Attribute::Integer.new(:aggregate) => aggregate) }

    it 'returns self' do
      subject.yield.equal?(subject).should be(true)
    end
  end

  context 'when a function is provided' do
    subject { described_class.new(header) { |object| object.add(:function, function) } }

    let(:function) { attribute.add(attribute) }

    its(:functions) { should eql(Attribute::Integer.new(:function) => function) }

    it 'returns self' do
      subject.yield.equal?(subject).should be(true)
    end
  end

  context 'when a proc is provided' do
    subject { described_class.new(header) { |object| object.add(:proc, proc) } }

    let(:proc) { Proc.new {} }

    its(:functions) { should eql(Attribute::Object.new(:proc) => proc) }

    it 'returns self' do
      subject.yield.equal?(subject).should be(true)
    end
  end

  context 'when a block is provided' do
    subject { described_class.new(header) { |object| object.add(:block, &block) } }

    let(:block) { proc {} }

    its(:functions) { should eql(Attribute::Object.new(:block) => block) }

    it 'returns self' do
      subject.yield.equal?(subject).should be(true)
    end
  end

  context 'when a literal is provided' do
    subject { described_class.new(header) { |object| object.add(:literal, 1) } }

    its(:functions) { should eql(Attribute::Integer.new(:literal) => 1) }

    it 'returns self' do
      subject.yield.equal?(subject).should be(true)
    end
  end
end
