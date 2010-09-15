require 'spec_helper'

describe 'Veritas::Logic::Connective::Negation#project' do
  subject { object.project(attributes) }

  let(:klass)      { Logic::Connective::Negation       }
  let(:attribute)  { Attribute::Integer.new(:id)       }
  let(:other)      { Attribute::Integer.new(:other_id) }
  let(:attributes) { [ attribute ]                     }
  let(:object)     { klass.new(operand)                }

  context 'operand is removed' do
    let(:operand) { other.eq(1) }

    it { should be_nil }
  end

  context 'operand is not removed' do
    let(:operand) { attribute.eq(1) }

    it { should equal(object) }
  end
end
