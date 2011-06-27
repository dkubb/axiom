# encoding: utf-8

require 'spec_helper'

[ :mean, :average, :avg ].each do |method|
  describe Aggregate::Mean::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Aggregate::Mean::Methods } }
    let(:object)          { described_class.new.freeze                     }

    it { should be_instance_of(Aggregate::Mean) }

    its(:operand) { should equal(object) }
  end
end
