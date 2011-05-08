require 'spec_helper'

describe Algebra::Summarization::Summaries, '#to_hash' do
  subject { object.to_hash }

  let(:object)      { described_class.new(summarizers) }
  let(:summarizers) { { :count => mock('Summarizer') } }

  it 'matches the expected value' do
    key, value = subject.first
    key.should == :count
    value.should be_kind_of(Algebra::Summarization::Summary)
  end
end
