# encoding: utf-8

require 'spec_helper'

describe Aggregate::Sum, '#default' do
  subject { object.default }

  let(:object) { described_class.new(attribute) }

  # This is needed to test the contract that the DEFAULT constant is
  # used for the identity. Subclasses of this function may rely on this.
  def self.set_default_value(value)
    before do
      stub_const("#{described_class}::DEFAULT", value)
    end
  end

  context 'when the attribute is an Integer' do
    let(:attribute) { Attribute::Integer.new(:integer) }

    context 'with the default value of 0' do
      it { should be(0) }
    end

    context 'with a default value other than 0' do
      set_default_value(1)

      it { should be(1) }
    end
  end

  context 'when the attribute is a Float' do
    let(:attribute) { Attribute::Float.new(:float) }

    context 'with the default value of 0' do
      it { should eql(0.0) }
    end

    context 'with the default value other than 0' do
      set_default_value(1)

      it { should eql(1.0) }
    end
  end

  context 'when the attribute is a Decimal' do
    let(:attribute) { Attribute::Decimal.new(:decimal) }

    context 'with the default value of 0' do
      it { should eql(BigDecimal('0')) }
    end

    context 'with the default value other than 0' do
      set_default_value(1)

      it { should eql(BigDecimal('1')) }
    end
  end
end
