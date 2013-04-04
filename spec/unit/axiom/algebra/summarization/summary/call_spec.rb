# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization::Summary, '#call' do
  subject { object.call(tuple) }

  let(:object) { described_class.new(summarizer)               }
  let(:header) { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                      }

  context 'when the summarizer is a Proc' do
    let(:summarizer) { lambda { |accumulator, tuple| accumulator.to_i.succ } }

    context 'when there is no summary' do
      it { should be_nil }
    end

    context 'when there is a summary' do
      before do
        object.summarize_by(tuple, tuple)
      end

      it { should == 1 }
    end
  end

  context 'when the summarizer is an aggregate function' do
    let(:summarizer) { header.first.mean }

    context 'when there is no summary' do
      it { should be_nil }
    end

    context 'when there is a summary' do
      before do
        object.summarize_by(tuple, tuple)
      end

      it { should == 1 }
    end
  end
end
