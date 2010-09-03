require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate::AlwaysFalse#optimize' do
  subject { object.optimize }

  let(:klass)     { Class.new(Optimizer::Logic::Predicate)                 }
  let(:attribute) { Attribute::Integer.new(:id)                            }
  let(:predicate) { Logic::Predicate::Inequality.new(attribute, attribute) }
  let(:object)    { klass.new(predicate)                                   }

  before do
    klass.class_eval { include Optimizer::Logic::Predicate::AlwaysFalse }
  end

  it { should equal(Logic::Proposition::False.instance) }
end
