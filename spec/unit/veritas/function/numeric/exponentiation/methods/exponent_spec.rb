require 'spec_helper'

[ :exponent, :**, :pow ].each do |method|
  describe Function::Numeric::Exponentiation::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Exponentiation::Methods } }
    let(:object)          { described_class.new.freeze                                       }
    let(:other)           { mock('Other').freeze                                             }

    it { should be_kind_of(Function::Numeric::Exponentiation) }

    its(:left) { should equal(object) }

    its(:right) { should equal(other) }
  end
end
