# encoding: utf-8

require 'spec_helper'

[:subtract, :-].each do |method|
  describe Function::Numeric::Subtraction::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Subtraction::Methods } }
    let(:object)          { described_class.new.freeze                                    }
    let(:other)           { double('Other').freeze                                        }

    it { should be_instance_of(Function::Numeric::Subtraction) }

    its(:left) { should be(object) }

    its(:right) { should be(other) }
  end
end
