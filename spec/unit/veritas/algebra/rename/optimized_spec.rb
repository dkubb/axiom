require 'spec_helper'

describe 'Veritas::Algebra::Rename#optimized?' do
  subject { rename.optimized? }

  let(:relation) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ]) }
  let(:aliases)  { { :id => :other_id }                                                         }
  let(:rename)   { operand.rename(aliases)                                                      }

  context 'operand and aliases are optimized' do
    let(:operand) { relation }

    it { operand.should be_optimized }

    it { should be(true) }
  end

  context 'operand is optimized, aliases are not optimized' do
    let(:operand) { relation.rename(:name => :other_name) }

    it { relation.should be_optimized }

    it { should be(false) }
  end

  context 'operand is not optimized, aliases are optimized' do
    let(:operand) { relation.project(relation.header).project(relation.header) }

    it { operand.should_not be_optimized }

    it { should be(false) }
  end

  context 'operand and aliases are not optimized' do
    let(:operand) { relation.project(relation.header).project(relation.header).rename(:name => :other_name) }

    it { operand.should_not be_optimized }

    it { should be(false) }
  end
end
