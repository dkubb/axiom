require 'spec_helper'

describe Optimizer::Relation::Materialized::EmptyOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { Relation.new([ [ :id, Integer ] ], body) }
  let(:object)   { described_class.new(relation)            }

  context 'with a body containing no entries' do
    let(:body) { [] }

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:body) { [ [ 1 ] ] }

    it { should be(false) }
  end
end
