# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#insert' do
  subject { object.insert(other) }

  let(:object)       { described_class.new(operand, summarize_by, summarizers) }
  let(:other)        { double('other')                                         }
  let(:operand)      { Relation.new([[:id, Integer]], [])                      }
  let(:summarize_by) { operand.project([])                                     }
  let(:summarizers)  { { test: 1 }                                             }

  specify { expect { subject }.to raise_error(ImmutableRelationError, 'inserting into a summarization is impossible') }
end
