require 'spec_helper'

describe Optimizer::Algebra::Rename::RenameOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.rename(:name => :other_name).rename(:id => :other_id)    }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Algebra::Rename)
  end

  it { should be_kind_of(Algebra::Rename) }

  its(:operand) { should equal(base) }

  its(:header) { should == [ [ :other_id, Integer ], [ :other_name, String ] ] }
end
