require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename#aliases' do
  subject { object.aliases }

  let(:klass)     { Optimizer::Algebra::Rename           }
  let(:attribute) { Attribute::Integer.new(:id)          }
  let(:header)    { Relation::Header.new([ attribute ])  }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each) }
  let(:aliases)   { { :id => :other_id }                 }
  let(:object)    { klass.new(relation)                  }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is a rename' do
    let(:relation) { base.rename(aliases).rename(:other_id => :another_id) }

    it { should be_kind_of(Algebra::Rename::Aliases) }

    it { should == { attribute => attribute.rename(:another_id) } }
  end

  context 'when the operand is not a rename' do
    let(:relation) { base.rename(aliases) }

    it { should be_kind_of(Algebra::Rename::Aliases) }

    it { should == { attribute => attribute.rename(:other_id) } }
  end
end
