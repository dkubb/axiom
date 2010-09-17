require 'spec_helper'

describe 'Veritas::Algebra::Summarization.summarize' do
  subject { object.summarize(tuple, summary, summarizer) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)      { Tuple.new(header, [ 1 ])                   }
  let(:summarizer) { lambda { |acc, tuple| acc.to_i + 1 }       }
  let(:object)     { Algebra::Summarization                     }

  context 'when the accumulator is uninitialized' do
    let(:summary) { {} }

    it { should equal(object) }

    it { expect { subject }.to change { summary.dup }.from({}).to({ summarizer => 1 }) }
  end

  context 'when the accumulator is initialized' do
    let(:summary) { { summarizer => 1 } }

    it { should equal(object) }

    it { expect { subject }.to change { summary.dup }.from({ summarizer => 1 }).to({ summarizer => 2 }) }
  end
end
