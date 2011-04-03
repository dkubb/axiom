require 'spec_helper'

describe Optimizer::Algebra::Rename::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:operand)  { Relation::Empty.new([ [ :id, Integer ] ]) }
  let(:relation) { operand.rename(:id => :other_id)          }
  let(:object)   { described_class.new(relation)             }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(relation.header) }
end
