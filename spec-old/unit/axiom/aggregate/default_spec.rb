# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#default' do
  subject { object.default }

  let(:described_class) { Class.new(Aggregate)           }
  let(:object)          { described_class.new(attribute) }
  let(:attribute)       { Attribute::Integer.new(:id)    }

  it 'delegates to self.class.default' do
    return_value = double('Return Value')
    expect(described_class).to receive(:default).with(no_args).and_return(return_value)
    should be(return_value)
  end
end
