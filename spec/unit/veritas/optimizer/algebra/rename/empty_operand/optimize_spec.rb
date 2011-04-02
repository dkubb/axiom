require 'spec_helper'

describe Optimizer::Algebra::Rename::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::EmptyOperand  }
  let(:operand)  { Relation::Empty.new([ [ :id, Integer ] ]) }
  let(:relation) { operand.rename(:id => :other_id)          }
  let(:object)   { klass.new(relation)                       }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Empty)
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(relation.header) }
end
