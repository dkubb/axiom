# encoding: utf-8

require 'spec_helper'

describe Function, '.extract_value' do
  subject { object.extract_value(operand, tuple) }

  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:tuple)  { Tuple.new(header, [1])                    }
  let(:object) { described_class                           }

  context 'when the operand responds to #call' do
    let(:operand) { header[:id] }

    it { should == 1 }
  end

  context 'when the operand does not respond to #call' do
    let(:operand) { double('Value') }

    it { should be(operand) }
  end
end
