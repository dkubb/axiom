# encoding: utf-8

require 'spec_helper'

[:absolute, :abs].each do |method|
  describe Function::Numeric::Absolute::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Function::Numeric::Absolute::Methods } }
    let(:object)          { described_class.new.freeze                                 }

    it { should be_instance_of(Function::Numeric::Absolute) }

    its(:operand) { should equal(object) }
  end
end
