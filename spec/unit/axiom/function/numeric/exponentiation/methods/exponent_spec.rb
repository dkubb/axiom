# encoding: utf-8

require 'spec_helper'

[:exponent, :**, :pow].each do |method|
  describe Function::Numeric::Exponentiation::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Exponentiation::Methods } }
    let(:object)          { described_class.new.freeze                                       }
    let(:other)           { Object.new.freeze                                                }

    it { should be_instance_of(Function::Numeric::Exponentiation) }

    its(:left) { should be(object) }

    its(:right) { should be(other) }
  end
end
