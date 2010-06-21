require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#optimize' do
  subject { complement.optimize }

  let(:attribute) { Attribute::Integer.new(:id) }

  context 'operand is a predicate' do
    let(:operand)    { attribute.gt(1)                            }
    let(:complement) { Logic::Connective::Complement.new(operand) }

    it { should eql(attribute.lte(1)) }

    it_should_behave_like 'an idempotent method'
  end

  context 'operand is a complemented predicate' do
    let(:predicate)  { attribute.gt(1)                              }
    let(:operand)    { Logic::Connective::Complement.new(predicate) }
    let(:complement) { Logic::Connective::Complement.new(operand)   }

    it { should eql(predicate) }

    it_should_behave_like 'an idempotent method'
  end

  context 'operand is a true proposition' do
    let(:operand)    { Logic::Proposition::True.instance          }
    let(:complement) { Logic::Connective::Complement.new(operand) }

    it { should equal(Logic::Proposition::False.instance) }

    it_should_behave_like 'an idempotent method'
  end

  context 'operand is a false proposition' do
    let(:operand)    { Logic::Proposition::False.instance         }
    let(:complement) { Logic::Connective::Complement.new(operand) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an idempotent method'
  end
end
