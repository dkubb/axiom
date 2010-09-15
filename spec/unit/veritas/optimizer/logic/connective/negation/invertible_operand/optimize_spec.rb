require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Negation::InvertibleOperand#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Logic::Connective::Negation::InvertibleOperand }
  let(:attribute) { Attribute::Integer.new(:id)                               }
  let(:operand)   { attribute.eq(1)                                           }
  let(:negation)  { Logic::Connective::Negation.new(operand)                  }
  let(:object)    { klass.new(negation)                                       }

  before do
    object.operation.should be_kind_of(Logic::Connective::Negation)
  end

  it { should eql(attribute.ne(1)) }
end
