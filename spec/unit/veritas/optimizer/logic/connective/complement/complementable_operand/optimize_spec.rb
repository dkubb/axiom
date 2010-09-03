require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Connective::Complement::ComplementableOperand#optimize' do
  subject { object.optimize }

  let(:klass)      { Optimizer::Logic::Connective::Complement::ComplementableOperand }
  let(:attribute)  { Attribute::Integer.new(:id)                                     }
  let(:operand)    { attribute.eq(1)                                                 }
  let(:complement) { Logic::Connective::Complement.new(operand)                      }
  let(:object)     { klass.new(complement)                                           }

  before do
    object.operation.should be_kind_of(Logic::Connective::Complement)
  end

  it { should eql(attribute.ne(1)) }
end
