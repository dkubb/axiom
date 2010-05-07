require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Negation#eql?' do
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:operand)   { attribute.eq(1)                          }
  let(:negation)  { Logic::Connective::Negation.new(operand) }

  subject { negation.eql?(other) }

  context 'with the same negation' do
    let(:other) { negation }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(negation)
    end
  end

  context 'with an equivalent negation' do
    let(:other) { negation.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(negation)
    end
  end

  context 'with a different negation' do
    let(:other_attribute) { Attribute::String.new(:name)                   }
    let(:other_operand)   { other_attribute.eq('Dan Kubb')                 }
    let(:other)           { Logic::Connective::Negation.new(other_operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(negation)
    end
  end

  context 'with an equivalent negation of a different class' do
    let(:other) { Class.new(Logic::Connective::Negation).new(operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(negation)
    end
  end
end
