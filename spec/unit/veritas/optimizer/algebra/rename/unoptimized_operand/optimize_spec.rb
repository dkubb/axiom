require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::UnoptimizedOperand     }
  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:relation) { base.rename(:id => :other_id)                      }
  let(:object)   { klass.new(relation)                                }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  it { should_not equal(relation) }

  it { should eql(relation) }

  its(:aliases) { should equal(relation.aliases) }
end
