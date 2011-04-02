require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::FalseRightOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Disjunction::FalseRightOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                                  }
  let(:left)       { attribute.eq(1)                                              }
  let(:right)      { Logic::Proposition::False.instance                           }
  let(:connective) { left.or(right)                                               }
  let(:object)     { klass.new(connective)                                        }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  it { should equal(left) }
end
