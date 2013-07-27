# encoding: utf-8

require 'spec_helper'

[:multiply, :*].each do |method|
  describe Function::Numeric::Multiplication::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Multiplication::Methods } }
    let(:object)          { described_class.new.freeze                                       }
    let(:other)           { double('Other').freeze                                           }

    it { should be_instance_of(Function::Numeric::Multiplication) }

    its(:left) { should be(object) }

    its(:right) { should be(other) }
  end
end
