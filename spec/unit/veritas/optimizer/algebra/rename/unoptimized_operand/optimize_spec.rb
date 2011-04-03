require 'spec_helper'

describe Optimizer::Algebra::Rename::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:relation) { base.rename({}).rename(:id => :other_id)           }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Rename) }

  it { should_not equal(relation) }

  its(:operand) { should equal(base) }

  its(:aliases) { should equal(relation.aliases) }
end
