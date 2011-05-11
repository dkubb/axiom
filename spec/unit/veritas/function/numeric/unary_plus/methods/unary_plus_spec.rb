require 'spec_helper'

[ :unary_plus, :+@ ].each do |method|
  describe Function::Numeric::UnaryPlus::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Function::Numeric::UnaryPlus::Methods } }
    let(:object)          { described_class.new.freeze                                  }

    it { should be_kind_of(Function::Numeric::UnaryPlus) }

    its(:operand) { should equal(object) }
  end
end
