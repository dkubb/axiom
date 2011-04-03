require 'spec_helper'

describe Optimizer::Algebra::Restriction::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])    }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)          }
  let(:relation) { base.rename({}).restrict { |r| r[:id].eq(1) } }
  let(:object)   { described_class.new(relation)                 }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  it { should_not equal(relation) }

  its(:operand) { should equal(base) }

  its(:predicate) { should == base[:id].eq(1) }
end
