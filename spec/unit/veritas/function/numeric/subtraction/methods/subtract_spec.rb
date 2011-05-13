# encoding: utf-8

require 'spec_helper'

[ :subtract, :- ].each do |method|
  describe Function::Numeric::Subtraction::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Subtraction::Methods } }
    let(:object)          { described_class.new.freeze                                    }
    let(:other)           { mock('Other').freeze                                          }

    it { should be_kind_of(Function::Numeric::Subtraction) }

    its(:left) { should equal(object) }

    its(:right) { should equal(other) }
  end
end
