require 'spec_helper'

describe Optimizer::Logic::Predicate::AlwaysTrue, '#optimize' do
  subject { object.optimize }

  let(:klass)     { Class.new(Optimizer::Logic::Predicate)               }
  let(:attribute) { Attribute::Integer.new(:id)                          }
  let(:predicate) { Logic::Predicate::Equality.new(attribute, attribute) }
  let(:object)    { klass.new(predicate)                                 }

  before do
    klass.class_eval { include Optimizer::Logic::Predicate::AlwaysTrue }
  end

  it { should equal(Logic::Proposition::True.instance) }
end
