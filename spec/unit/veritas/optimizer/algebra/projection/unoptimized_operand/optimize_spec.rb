require 'spec_helper'

describe Optimizer::Algebra::Projection::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Projection::UnoptimizedOperand                }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])     }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)                  }
  let(:relation) { base.restrict(Logic::Proposition::True.instance).project([ :id ]) }
  let(:object)   { klass.new(relation)                                               }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  it { should be_kind_of(Algebra::Projection) }

  its(:operand) { should equal(base) }

  its(:header) { should == [ header[:id] ] }
end
