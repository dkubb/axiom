# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Methods, '#summarize' do
  subject { object.summarize(summarize_with, &block) }

  let(:described_class) { Relation                                                  }
  let(:summarizers)     { [ :test, lambda { |acc, tuple| 1 } ]                      }
  let(:block)           { lambda { |r| r.add(*summarizers) }                        }
  let(:object)          { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }

  context 'when summarizing per a relation' do
    let(:summarize_with) { object.project([]) }

    it { should be_kind_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should equal(summarize_with) }
  end

  context 'when summarizing by a header' do
    let(:summarize_with) { [] }

    it { should be_kind_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_per) { should == object.project(summarize_with) }
  end
end
