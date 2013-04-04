# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#delete' do
  subject { object.delete(other) }

  let(:object)       { described_class.new(operand, summarize_by, summarizers) }
  let(:other)        { stub('other')                                           }
  let(:operand)      { Relation.new([ [ :id, Integer ] ], [])                  }
  let(:summarize_by) { operand.project([])                                     }
  let(:summarizers)  { { :test => 1 }                                          }

  specify { expect { subject }.to raise_error(ImmutableRelationError, 'deleting from a summarization is impossible') }
end
