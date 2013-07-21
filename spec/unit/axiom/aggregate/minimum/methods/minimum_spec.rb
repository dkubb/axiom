# encoding: utf-8

require 'spec_helper'

[:minimum, :min].each do |method|
  describe Aggregate::Minimum::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Aggregate::Minimum::Methods } }
    let(:object)          { described_class.new.freeze                        }

    it { should be_instance_of(Aggregate::Minimum) }

    its(:operand) { should equal(object) }
  end
end
