require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#project' do
  subject { complement.project(attributes) }

  let(:attribute)  { Attribute::Integer.new(:id)       }
  let(:other)      { Attribute::Integer.new(:other_id) }
  let(:attributes) { [ attribute ]                     }

  context 'operand is removed' do
    let(:operand)    { other.eq(1)                                }
    let(:complement) { Logic::Connective::Complement.new(operand) }

    it { should be_nil }
  end

  context 'operand is not removed' do
    let(:operand)    { attribute.eq(1)                            }
    let(:complement) { Logic::Connective::Complement.new(operand) }

    it { should equal(complement) }
  end
end
