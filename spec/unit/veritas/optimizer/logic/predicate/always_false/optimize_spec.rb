require 'spec_helper'

describe Optimizer::Logic::Predicate::AlwaysFalse, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer::Logic::Predicate)                 }
  let(:attribute)       { Attribute::Integer.new(:id)                            }
  let(:predicate)       { Logic::Predicate::Inequality.new(attribute, attribute) }
  let(:object)          { described_class.new(predicate)                         }

  before do
    described_class.class_eval { include Optimizer::Logic::Predicate::AlwaysFalse }
  end

  it { should equal(Logic::Proposition::False.instance) }
end
