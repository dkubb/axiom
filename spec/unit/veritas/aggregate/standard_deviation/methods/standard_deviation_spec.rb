require 'spec_helper'

[ :standard_deviation, :stddev ].each do |method|
  describe Aggregate::StandardDeviation::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Aggregate::StandardDeviation::Methods } }
    let(:object)          { described_class.new.freeze                                  }

    it { should be_kind_of(Aggregate::StandardDeviation) }

    its(:operand) { should equal(object) }
  end
end
