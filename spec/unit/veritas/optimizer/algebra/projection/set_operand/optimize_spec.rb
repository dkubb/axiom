require 'spec_helper'

describe Optimizer::Algebra::Projection::SetOperand, '#optimize' do
  subject { object.optimize }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ]) }
  let(:base_left)  { Relation.new(header, [ [ 1, 'Dan Kubb', 35 ] ].each)                             }
  let(:base_right) { Relation.new(header, [ [ 2, 'Dan Kubb', 35 ] ].each)                             }
  let(:left)       { base_left.rename({})                                                             }
  let(:right)      { base_right.rename({})                                                            }
  let(:relation)   { left.union(right).project([ :id ])                                               }
  let(:object)     { described_class.new(relation)                                                    }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Set) }

  its(:left) { should eql(base_left.project([ :id ])) }

  its(:right) { should eql(base_right.project([ :id ])) }
end
