require 'spec_helper'

describe Optimizer::Algebra::Rename::RenameOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { operand.rename(aliases)                                       }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is a rename' do
    let(:aliases) { { :id => :other_id }              }
    let(:operand) { base.rename(:name => :other_name) }

    it { should be(true) }
  end

  context 'when the operand is not a rename' do
    let(:aliases) { { :id => :other_id } }
    let(:operand) { base                 }

    it { should be(false) }
  end
end
