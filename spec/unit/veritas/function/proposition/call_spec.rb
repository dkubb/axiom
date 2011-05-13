# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#call' do
  subject { object.call }

  let(:described_class) { Class.new(Function::Proposition) }
  let(:object)          { described_class.new              }

  it 'calls self.class.call' do
    response = mock('#call response')
    described_class.should_receive(:call).and_return(response)
    should equal(response)
  end
end
