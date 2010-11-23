require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::OffsetOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::OffsetOperand   }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])  }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)        }
  let(:relation) { base.order.drop(1).rename(:id => :other_id) }
  let(:object)   { klass.new(relation)                         }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Operation::Offset)
  end

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:operand) { should eql(base.rename(:id => :other_id).order) }

  its(:offset) { should == 1 }
end
