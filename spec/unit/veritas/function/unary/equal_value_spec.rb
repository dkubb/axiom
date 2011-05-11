require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Unary, '#==' do
  subject { object == other }

  let(:described_class) { UnarySpecs::Object                  }
  let(:attribute)       { Attribute::Integer.new(:id)         }
  let(:header)          { Relation::Header.new([ attribute ]) }
  let(:operand)         { attribute.eq(1)                     }
  let(:object)          { described_class.new(operand)        }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(operand) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an object having a different operand' do
    let(:other_operand) { attribute.ne(1)                    }
    let(:other)         { described_class.new(other_operand) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
