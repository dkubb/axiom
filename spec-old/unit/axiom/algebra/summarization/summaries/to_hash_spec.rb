# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Summaries, '#to_hash' do
  subject { object.to_hash }

  let(:object)      { described_class.new(header, summarizers) }
  let(:header)      { double('Header')                         }
  let(:summarizers) { { count: double('Summarizer') }          }

  it 'matches the expected value' do
    key, value = subject.first
    expect(key).to eql(:count)
    expect(value).to be_instance_of(Algebra::Summarization::Summary)
  end
end
