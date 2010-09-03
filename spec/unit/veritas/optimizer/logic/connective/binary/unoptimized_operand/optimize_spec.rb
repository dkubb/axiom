require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Binary::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Binary::UnoptimizedOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                              }
  let(:left)       { attribute.include([ 1 ])                                 }
  let(:right)      { attribute.exclude([ 2 ])                                 }
  let(:connective) { left.and(right)                                          }
  let(:object)     { klass.new(connective)                                    }

  before do
    object.operation.should be_kind_of(Logic::Connective::Binary)
  end

  it { should eql(attribute.eq(1).and(attribute.ne(2))) }
end
