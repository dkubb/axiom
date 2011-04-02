require 'spec_helper'

describe Algebra::Summarization::Methods, '#summarize' do
  subject { object.summarize(summarize_by, &block) }

  let(:described_class) { Relation                                                  }
  let(:summarizers)     { [ :test, lambda { |acc, tuple| 1 } ]                      }
  let(:block)           { lambda { |r| r.add(*summarizers) }                        }
  let(:object)          { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }

  context 'when summarizing by a relation' do
    let(:summarize_by) { object }

    it { should be_kind_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_by) { should equal(summarize_by) }
  end

  context 'when summarizing by a header' do
    let(:summarize_by) { [ :id ] }

    it { should be_kind_of(Algebra::Summarization) }

    its(:operand) { should equal(object) }

    its(:summarize_by) { should == object.project(summarize_by) }
  end
end
