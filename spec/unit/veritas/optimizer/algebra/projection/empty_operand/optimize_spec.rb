require 'spec_helper'

describe Optimizer::Algebra::Projection::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation::Empty.new(header)                                   }
  let(:relation) { base.project([ :id ])                                         }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(relation.header) }
end
