# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Methods, '#summarize' do
  subject { object.summarize(summarize_with, &block) }

  let(:object)          { described_class.new([ [ :id, Integer ], [ :name, String ] ], LazyEnumerable.new([ [ 1, 'Dan Kubb' ] ])) }
  let(:described_class) { Relation                                                                                                }
  let(:block)           { lambda { |r| r.add(:test, r.id.count) }                                                                 }
  let(:summarizers)     { [ :test, function ]                                                                                     }
  let(:function)        { object[:id].count                                                                                       }

  context 'with no arguments' do
    subject { object.summarize(&block) }

    it { should be_instance_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should equal(TABLE_DEE) }

    its(:summarizers) { should eql(Attribute::Integer.new(:test) => function) }
  end

  context 'with a relation' do
    let(:summarize_with) { object.project([]) }

    it { should be_instance_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should equal(summarize_with) }

    its(:summarizers) { should eql(Attribute::Integer.new(:test) => function) }
  end

  context 'with a header' do
    let(:summarize_with) { object.project([]).header }

    it { should be_instance_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should eql(object.project(summarize_with)) }

    its(:summarizers) { should eql(Attribute::Integer.new(:test) => function) }
  end

  context 'with attributes' do
    let(:summarize_with) { [ :name ] }

    it { should be_instance_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should eql(object.project(summarize_with)) }

    its(:summarizers) { should eql(Attribute::Integer.new(:test) => function) }
  end

  context 'with summarizers' do
    subject { object.summarize(summarize_with, summarizers) }

    let(:summarize_with) { object.project([])                           }
    let(:summarizers)    { { Attribute::Object.new(:test) => function } }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should eql(summarize_with) }

    its(:summarizers) { should eql(summarizers) }
  end

  context 'with a header containing an attribute used in the context block' do
    let(:summarize_with) { object.project([ :id ])                  }
    let(:block)          { lambda { |r| r.add(:count, r.id.count) } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
