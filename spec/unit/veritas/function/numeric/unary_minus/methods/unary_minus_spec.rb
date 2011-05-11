require 'spec_helper'

[ :unary_minus, :-@ ].each do |method|
  describe Function::Numeric::UnaryMinus::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Function::Numeric::UnaryMinus::Methods } }
    let(:object)          { described_class.new.freeze                                   }

    it { should be_kind_of(Function::Numeric::UnaryMinus) }

    its(:operand) { should equal(object) }
  end
end
