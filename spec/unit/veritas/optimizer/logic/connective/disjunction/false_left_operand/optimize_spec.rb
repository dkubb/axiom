require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Disjunction::FalseLeftOperand#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Disjunction::FalseLeftOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:left)       { Logic::Proposition::False.instance                          }
  let(:right)      { attribute.eq(1)                                             }
  let(:connective) { Logic::Connective::Disjunction.new(left, right)             }
  let(:object)     { klass.new(connective)                                       }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  it { should equal(right) }
end
