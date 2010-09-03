require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::UnoptimizedOperand#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Optimizer::Algebra::Rename::UnoptimizedOperand }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])     }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)           }
  let(:relation) { operand.rename(aliases)                        }
  let(:object)   { klass.new(relation)                            }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand and aliases are optimizable' do
    let(:aliases) { { :other_id => :another_id }                  }
    let(:operand) { base.project(header).rename(:id => :other_id) }

    it { should be(true) }
  end

  context 'when the operand is optimizable, but the aliases are not optimizable' do
    let(:aliases) { { :id => :other_id } }
    let(:operand) { base.project(header) }

    it { should be(true) }
  end

  context 'when the operand is not optimizable, but the aliases are optimizable' do
    let(:aliases) { { :other_id => :another_id }  }
    let(:operand) { base.rename(:id => :other_id) }

    it { should be(true) }
  end

  context 'when the operand and aliases are not optimizable' do
    let(:aliases) { { :id => :other_id } }
    let(:operand) { base                 }

    it { should be(false) }
  end
end
