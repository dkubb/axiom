# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Binary, '#==' do
  subject { object == other }

  let(:described_class) { BinarySpecs::Object                  }
  let(:attribute)       { Attribute::Integer.new(:id)          }
  let(:header)          { Relation::Header.coerce([attribute]) }
  let(:left)            { attribute.eq(1)                      }
  let(:right)           { attribute.eq(2)                      }
  let(:object)          { described_class.new(left, right)     }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(left, right) }

    it { should be(true) }

    it 'is not symmetric' do
      should_not eql(other == object)
    end
  end

  context 'with an object having a different left operand' do
    let(:other_left) { attribute.ne(1)                        }
    let(:other)      { described_class.new(other_left, right) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an object having a different right operand' do
    let(:other_right) { attribute.ne(2)                        }
    let(:other)       { described_class.new(left, other_right) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end
end
