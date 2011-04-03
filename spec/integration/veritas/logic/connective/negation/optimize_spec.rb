require 'spec_helper'

describe Logic::Connective::Negation, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)  }
  let(:object)    { described_class.new(operand) }

  context 'operand is a predicate' do
    let(:operand) { attribute.gt(1) }

    it { should eql(attribute.lte(1)) }

    it_should_behave_like 'an optimize method'
  end

  context 'operand is a objected predicate' do
    let(:predicate) { attribute.gt(1)                }
    let(:operand)   { described_class.new(predicate) }

    it { should eql(predicate) }

    it_should_behave_like 'an optimize method'
  end

  context 'operand is a true proposition' do
    let(:operand) { Logic::Proposition::True.instance }

    it { should equal(Logic::Proposition::False.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'operand is a false proposition' do
    let(:operand) { Logic::Proposition::False.instance }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end
end
