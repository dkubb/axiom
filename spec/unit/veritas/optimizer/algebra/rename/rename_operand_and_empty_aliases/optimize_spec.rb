require 'spec_helper'

describe Optimizer::Algebra::Rename::RenameOperandAndEmptyAliases, '#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::RenameOperandAndEmptyAliases      }
  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { base.rename(:id => :other_id).rename(:other_id => :id)        }
  let(:object)   { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Algebra::Rename)
  end

  it { should equal(base) }
end
