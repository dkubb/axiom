# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Methods, '#summarize' do
  subject { object.summarize(summarize_with, &block) }

  let(:described_class) { Relation                                                                                 }
  let(:summarizers)     { [ :test, lambda { |acc, tuple| 1 } ]                                                     }
  let(:block)           { lambda { |r| r.add(*summarizers) }                                                       }
  let(:object)          { described_class.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ].each) }

  context 'with no arguments' do
    subject { object.summarize(&block) }

    it { should be_kind_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should equal(TABLE_DEE) }
  end

  context 'with a relation' do
    let(:summarize_with) { object.project([]) }

    it { should be_kind_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should equal(summarize_with) }
  end

  context 'with a header' do
    let(:summarize_with) { object.project([]).header }

    it { should be_kind_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should == object.project(summarize_with) }
  end

  context 'with a header containing an attribute used in the context block' do
    let(:summarize_with) { object.project([ :id ])                  }
    let(:block)          { lambda { |r| r.add(:count, r.id.count) } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
