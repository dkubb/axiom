require 'spec_helper'

describe Optimizer::Algebra::Rename::RestrictionOperand, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)              }
  let(:predicate) { base[:id].eq(1)                                   }
  let(:relation)  { base.restrict(predicate).rename(:id => :other_id) }
  let(:object)    { described_class.new(relation)                     }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should eql(base.rename(:id => :other_id)) }

  its(:predicate) { should == header[:id].rename(:other_id).eq(1) }
end
