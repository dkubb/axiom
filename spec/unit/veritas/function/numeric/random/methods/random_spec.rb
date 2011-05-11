require 'spec_helper'

[ :random, :rand ].each do |method|
  describe Function::Numeric::Random::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Function::Numeric::Random::Methods } }
    let(:object)          { described_class.new.freeze                               }

    it { should be_kind_of(Function::Numeric::Random) }

    its(:operand) { should equal(object) }
  end
end
