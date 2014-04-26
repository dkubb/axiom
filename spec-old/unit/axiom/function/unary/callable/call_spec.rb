# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Callable, '#call' do
  subject { object.call(value) }

  let(:object)   { double('object', operation: :op).extend(self.class.described_class) }
  let(:value)    { double('value', op: response)                                       }
  let(:response) { double('response')                                                  }

  it { should be(response) }
end
