# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '.new' do
  subject { object.new(operand, summarize_per, summarizers) }

  let(:header)      { [ [ :id, Integer ], [ :name, String ] ]                        }
  let(:operand)     { Relation.new(header, [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ]) }
  let(:summarizers) { {}                                                             }
  let(:object)      { described_class                                                }

  context 'with a summarize_per that has a subset of the headers in the operand' do
    let(:summarize_per) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

    it { should be_instance_of(object) }
  end

  context 'with a summarize_per that has equivalent headers to the headers in the operand' do
    let(:summarize_per) { operand }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the summarize_per header must be a proper subset of the operand header') }
  end

  context 'with a summarize_per that has a superset of the headers in the operand' do
    let(:summarize_per) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the summarize_per header must be a proper subset of the operand header') }
  end
end
