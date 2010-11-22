require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Conjunction::TrueLeftOperand#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Conjunction::TrueLeftOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                                }
  let(:left)       { Logic::Proposition::True.instance                          }
  let(:right)      { attribute.eq(1)                                            }
  let(:connective) { Logic::Connective::Conjunction.new(left, right)            }
  let(:object)     { klass.new(connective)                                      }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  it { should equal(right) }
end
