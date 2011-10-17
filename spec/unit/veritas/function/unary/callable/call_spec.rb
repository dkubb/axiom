# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Callable, '#call' do
  subject { object.call(value) }

  let(:object)    { mock('object', :operation => :op).extend(self.class.described_type) }
  let(:value)     { mock('value', :send => response)                                    }
  let(:response)  { mock('response')                                                    }

  it { should equal(response) }

  it 'uses the operation from the object' do
    object.should_receive(:operation)
    subject
  end

  it 'delegates the operation to the value' do
    value.should_receive(:send).with(:op)
    subject
  end
end
