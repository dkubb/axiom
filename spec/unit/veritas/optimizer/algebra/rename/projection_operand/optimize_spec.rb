require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::ProjectionOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::ProjectionOperand                 }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.project([ :id ]).rename(:id => :other_id)                }
  let(:object)   { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Algebra::Projection)
  end

  it { should be_kind_of(Algebra::Projection) }

  its(:operand) { should eql(base.rename(:id => :other_id)) }

  its(:header) { should == [ [ :other_id, Integer ] ] }
end
