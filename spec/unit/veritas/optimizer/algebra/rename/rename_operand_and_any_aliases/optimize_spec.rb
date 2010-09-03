require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::RenameOperandAndAnyAliases#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::RenameOperandAndAnyAliases        }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.rename(:name => :other_name).rename(:id => :other_id)    }
  let(:object)   { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Algebra::Rename)
  end

  it { should eql(base.rename(:id => :other_id, :name => :other_name)) }
end
