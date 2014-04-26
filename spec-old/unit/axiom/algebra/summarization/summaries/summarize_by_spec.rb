# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Summaries, '#summarize_by' do
  subject { object.summarize_by(tuple) }

  let(:object)       { described_class.new(header, summarizers)                   }
  let(:summarizers)  { { count: summarizer }                                      }
  let(:summarizer)   { double('Summarizer', call: 1)                              }
  let(:header)       { Relation::Header.coerce([[:id, Integer]])                  }
  let(:tuple_header) { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:tuple)        { Tuple.new(tuple_header, [1, 'Dan Kubb'])                   }

  it_should_behave_like 'a command method'

  it 'passes the tuple to the aggregate function' do
    expect(summarizer).to receive(:call).with(nil, tuple)
    subject
  end

  it 'aggregates the value returned by the summarizer' do
    key, value = subject.to_hash.first
    expect(key).to eql(:count)
    expect(value).to be_instance_of(Algebra::Summarization::Summary)
    expect(value.call(tuple.project(header))).to eql(1)
  end
end
