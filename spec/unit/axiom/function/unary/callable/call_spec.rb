# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Callable, '#call' do
  subject { object.call(value) }

  let(:object)    { double('object', operation: :op).extend(self.class.described_class) }
  let(:value)     { double('value', send: response)                                     }
  let(:response)  { double('response')                                                  }

  it { should be(response) }

  it 'uses the operation from the object' do
    expect(object).to receive(:operation)
    subject
  end

  it 'delegates the operation to the value' do
    expect(value).to receive(:send).with(:op)
    subject
  end
end
