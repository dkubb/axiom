require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Binary::RedundantLeftOperand#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Binary::RedundantLeftOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                                }
  let(:left)       { attribute.include([ 1 ])                                   }
  let(:right)      { attribute.exclude([ 2 ])                                   }
  let(:connective) { left.and(right).and(right)                                 }
  let(:object)     { klass.new(connective)                                      }

  before do
    object.operation.should be_kind_of(Logic::Connective::Binary)
  end

  it { should be_kind_of(Logic::Connective::Conjunction) }

  its(:left) { should eql(attribute.eq(1)) }

  its(:right) { should eql(attribute.ne(2)) }
end
