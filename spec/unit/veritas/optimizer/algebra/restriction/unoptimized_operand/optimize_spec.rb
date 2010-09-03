require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Restriction::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Restriction::UnoptimizedOperand }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])          }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)                }
  let(:relation) { base.restrict { |r| r[:id].eq(1) }                  }
  let(:object)   { klass.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  it { should_not equal(relation) }

  it { should eql(relation) }

  its(:operand) { should equal(base) }
end
