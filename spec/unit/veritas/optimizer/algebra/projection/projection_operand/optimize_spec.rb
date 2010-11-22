require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Projection::ProjectionOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Projection::ProjectionOperand                                }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb', 35 ] ].each)                             }
  let(:relation) { base.project([ :id, :name ]).project([ :id ])                                    }
  let(:object)   { klass.new(relation)                                                              }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  it { should be_kind_of(Algebra::Projection) }

  its(:operand) { should equal(base) }

  its(:header) { should == [ header[:id] ] }
end
