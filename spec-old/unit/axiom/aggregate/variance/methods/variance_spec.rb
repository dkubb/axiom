# encoding: utf-8

require 'spec_helper'

[:variance, :var].each do |method|
  describe Aggregate::Variance::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Aggregate::Variance::Methods } }
    let(:object)          { described_class.new.freeze                         }

    it { should be_instance_of(Aggregate::Variance) }

    its(:operand) { should be(object) }
  end
end
