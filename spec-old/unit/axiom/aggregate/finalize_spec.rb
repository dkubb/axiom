# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#finalize' do
  subject { object.finalize(accumulator) }

  let(:described_class) { Class.new(Aggregate)           }
  let(:object)          { described_class.new(attribute) }
  let(:attribute)       { Attribute::Integer.new(:id)    }
  let(:accumulator)     { double('Accumulator')          }

  it 'delegates to self.class.finalize' do
    return_value = double('Return Value')
    expect(described_class).to receive(:finalize).with(accumulator).and_return(return_value)
    should be(return_value)
  end
end
