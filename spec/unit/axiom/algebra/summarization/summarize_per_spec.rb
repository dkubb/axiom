# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#summarize_per' do
  subject { object.summarize_per }

  let(:operand)     { Relation.new([[:id, Integer]], [[1], [2]])           }
  let(:summarizers) { { test: ->(_acc, _tuple) { 1 } }                     }
  let(:object)      { described_class.new(operand, TABLE_DEE, summarizers) }

  it_should_behave_like 'an idempotent method'

  it { should be(TABLE_DEE) }
end
