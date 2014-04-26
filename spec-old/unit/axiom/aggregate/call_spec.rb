# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#call' do
  subject { object.call(accumulator, tuple) }

  let(:object)          { described_class.new(attribute)    }
  let(:described_class) { Class.new(Aggregate)              }
  let(:accumulator)     { double('accumulator')             }
  let(:attribute)       { Attribute::Integer.new(:id)       }
  let(:header)          { Relation::Header.new([attribute]) }
  let(:tuple)           { Tuple.new(header, [1])            }

  context 'when operand is an attribute' do
    before do
      expect(described_class).to receive(:call).with(accumulator, 1)
        .and_return(1)
    end

    it { should eql(1) }
  end

  context 'when operand is a literal value' do
    let(:object) { described_class.new(2) }

    before do
      expect(described_class).to receive(:call).with(accumulator, 2)
        .and_return(2)
    end

    it { should eql(2) }
  end

  context 'when .call is not defined' do
    specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}.call is not implemented") }
  end
end
