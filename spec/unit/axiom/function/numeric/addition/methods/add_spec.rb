# encoding: utf-8

require 'spec_helper'

[ :add, :+ ].each do |method|
  describe Function::Numeric::Addition::Methods, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new { include Function::Numeric::Addition::Methods } }
    let(:object)          { described_class.new.freeze                                 }
    let(:other)           { double('Other').freeze                                     }

    it { should be_instance_of(Function::Numeric::Addition) }

    its(:left) { should equal(object) }

    its(:right) { should equal(other) }
  end
end
