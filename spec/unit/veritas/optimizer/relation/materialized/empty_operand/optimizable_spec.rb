require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Materialized::EmptyOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Relation::Materialized::EmptyOperand }
  let(:relation) { Relation.new([ [ :id, Integer ] ], body)        }
  let(:object)   { klass.new(relation)                             }

  context 'with a body containing no entries' do
    let(:body) { [] }

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:body) { [ [ 1 ] ] }

    it { should be(false) }
  end
end
