require 'spec_helper'

describe 'Veritas::Algebra::Summarization#summarize_by' do
  subject { object.summarize_by }

  let(:klass)       { Algebra::Summarization                               }
  let(:operand)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:summarizers) { { :test => lambda { |acc, tuple| 1 } }               }
  let(:object)      { klass.new(operand, operand, summarizers)             }

  it { should equal(operand) }

  it_should_behave_like 'an idempotent method'
end
