require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::AlwaysTrue, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:left)       { Logic::Proposition::True.instance               }
  let(:right)      { Logic::Proposition::True.instance               }
  let(:connective) { Logic::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  it { should equal(Logic::Proposition::True.instance) }
end
