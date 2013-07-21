# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Summary, '#summarize_by' do
  subject { object.summarize_by(projection, tuple) }

  let(:object)     { described_class.new(summarizer)                  }
  let(:summarizer) { ->(accumulator, tuple) { accumulator.to_i.succ } }
  let(:header)     { Relation::Header.coerce([[:id, Integer]])        }
  let(:tuple)      { Tuple.new(header, [1])                           }
  let(:projection) { tuple.project([])                                }

  it_should_behave_like 'a command method'

  it 'aggregates the value returned by the summarizer' do
    2.times do
      subject
      __memoized.delete(:subject)  # bypass subject cache
    end
    object.call(projection).should eql(2)
  end
end
