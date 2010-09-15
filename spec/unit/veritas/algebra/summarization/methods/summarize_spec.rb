require 'spec_helper'

describe 'Veritas::Algebra::Summarization::Methods#summarize' do
  subject { object.summarize(object, &block) }

  let(:klass)       { Relation                                   }
  let(:summarizers) { [ :test, lambda { |acc, tuple| 1 } ]       }
  let(:block)       { lambda { |r| r.add(*summarizers) }         }
  let(:object)      { klass.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should be_kind_of(Algebra::Summarization) }

  its(:operand) { should equal(object) }

  its(:summarize_by) { should equal(object) }
end
