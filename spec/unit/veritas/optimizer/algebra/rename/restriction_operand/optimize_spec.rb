require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::RestrictionOperand#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Algebra::Rename::RestrictionOperand    }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)              }
  let(:predicate) { base[:id].eq(1)                                   }
  let(:relation)  { base.restrict(predicate).rename(:id => :other_id) }
  let(:object)    { klass.new(relation)                               }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Algebra::Restriction)
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should eql(base.rename(:id => :other_id)) }

  its(:predicate) { should == header[:id].rename(:other_id).eq(1) }
end
