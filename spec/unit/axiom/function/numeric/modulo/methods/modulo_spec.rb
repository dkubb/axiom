# encoding: utf-8

require 'spec_helper'

[ :modulo, :mod, :% ].each do |method|
  describe Function::Numeric::Modulo::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Modulo::Methods } }
    let(:object)          { described_class.new.freeze                               }
    let(:other)           { double('Other').freeze                                   }

    it { should be_instance_of(Function::Numeric::Modulo) }

    its(:left) { should equal(object) }

    its(:right) { should equal(other) }
  end
end
