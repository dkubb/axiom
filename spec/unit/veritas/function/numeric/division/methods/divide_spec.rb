# encoding: utf-8

require 'spec_helper'

[ :divide, :/ ].each do |method|
  describe Function::Numeric::Division::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Division::Methods } }
    let(:object)          { described_class.new.freeze                                 }
    let(:other)           { mock('Other').freeze                                       }

    it { should be_instance_of(Function::Numeric::Division) }

    its(:left) { should equal(object) }

    its(:right) { should equal(other) }
  end
end
