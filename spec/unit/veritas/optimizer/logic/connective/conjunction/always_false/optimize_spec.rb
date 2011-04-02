require 'spec_helper'

describe Optimizer::Logic::Connective::Conjunction::AlwaysFalse, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:left)       { Logic::Proposition::False.instance              }
  let(:right)      { Logic::Proposition::False.instance              }
  let(:connective) { Logic::Connective::Conjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.operation.should be_kind_of(Logic::Connective::Conjunction)
  end

  it { should equal(Logic::Proposition::False.instance) }
end
