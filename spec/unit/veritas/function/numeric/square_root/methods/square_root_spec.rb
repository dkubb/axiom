# encoding: utf-8

require 'spec_helper'

[ :square_root, :sqrt ].each do |method|
  describe Function::Numeric::SquareRoot::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Function::Numeric::SquareRoot::Methods } }
    let(:object)          { described_class.new.freeze                                   }

    it { should be_kind_of(Function::Numeric::SquareRoot) }

    its(:operand) { should equal(object) }
  end
end
