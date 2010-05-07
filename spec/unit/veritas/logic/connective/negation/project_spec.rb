require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#project' do
  subject { negation.project(attributes) }

  let(:attribute)  { Attribute::Integer.new(:id)       }
  let(:other)      { Attribute::Integer.new(:other_id) }
  let(:attributes) { [ attribute ]                     }

  context 'operand is removed' do
    let(:operand)  { other.eq(1)                              }
    let(:negation) { Logic::Connective::Negation.new(operand) }

    it { should be_nil }
  end

  context 'operand is not removed' do
    let(:operand)  { attribute.eq(1)                          }
    let(:negation) { Logic::Connective::Negation.new(operand) }

    it { should equal(negation) }
  end
end
