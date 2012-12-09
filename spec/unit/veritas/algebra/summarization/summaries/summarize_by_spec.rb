# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Summaries, '#summarize_by' do
  subject { object.summarize_by(header, tuple) }

  let(:object)      { described_class.new(summarizers)           }
  let(:summarizers) { { :count => summarizer }                   }
  let(:summarizer)  { mock('Summarizer', :call => 1)             }
  let(:header)      { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)       { Tuple.new(header, [ 1 ])                   }

  it_should_behave_like 'a command method'

  it 'passes the tuple to the aggregate function' do
    summarizer.should_receive(:call).with(nil, tuple)
    subject
  end

  it 'aggregates the value returned by the summarizer' do
    subject
    key, value = subject.to_hash.first
    key.should eql(:count)
    value.should be_instance_of(Algebra::Summarization::Summary)
    value.call(tuple).should eql(1)
  end
end
