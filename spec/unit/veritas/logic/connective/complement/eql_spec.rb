require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#eql?' do
  subject { complement.eql?(other) }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:operand)    { attribute.eq(1)                            }
  let(:complement) { Logic::Connective::Complement.new(operand) }

  context 'with the same complement' do
    let(:other) { complement }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(complement)
    end
  end

  context 'with an equivalent complement' do
    let(:other) { complement.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(complement)
    end
  end

  context 'with a different complement' do
    let(:other_attribute) { Attribute::String.new(:name)                     }
    let(:other_operand)   { other_attribute.eq('Dan Kubb')                   }
    let(:other)           { Logic::Connective::Complement.new(other_operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(complement)
    end
  end

  context 'with an equivalent complement of a different class' do
    let(:other) { Class.new(Logic::Connective::Complement).new(operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(complement)
    end
  end
end
