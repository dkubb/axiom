require 'spec_helper'

describe Optimizer::Logic::Predicate::Comparable::NormalizableOperands, '#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Logic::Predicate::Comparable::NormalizableOperands }
  let(:attribute) { Attribute::Integer.new(:id)                                   }
  let(:predicate) { Logic::Predicate::Equality.new(1, attribute)                  }
  let(:object)    { klass.new(predicate)                                          }

  before do
    predicate.should be_kind_of(Logic::Predicate::Comparable)
  end

  it { should be_kind_of(Logic::Predicate::Equality) }

  its(:left) { should equal(attribute) }

  its(:right) { should == 1 }
end
