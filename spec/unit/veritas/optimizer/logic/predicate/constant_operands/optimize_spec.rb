require 'spec_helper'

describe Optimizer::Logic::Predicate::ConstantOperands, '#optimize' do
  subject { object.optimize }

  let(:predicate) { Logic::Predicate::Equality.new(1, 1) }
  let(:object)    { described_class.new(predicate)       }

  it { should equal(Logic::Proposition::True.instance) }
end
