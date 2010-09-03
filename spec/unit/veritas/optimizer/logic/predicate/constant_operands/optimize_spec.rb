require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::ConstantOperands#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Logic::Predicate::ConstantOperands }
  let(:predicate) { Logic::Predicate::Equality.new(1, 1)          }
  let(:object)    { klass.new(predicate)                          }

  it { should equal(Logic::Proposition::True.instance) }
end
