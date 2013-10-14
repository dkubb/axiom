# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#call' do
  subject { object.call }

  let(:described_class) { Class.new(Function::Proposition) }
  let(:object)          { described_class.new              }

  it 'calls self.class.call' do
    response = double('#call response')
    expect(described_class).to receive(:call).and_return(response)
    should be(response)
  end
end
