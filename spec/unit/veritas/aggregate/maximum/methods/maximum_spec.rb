require 'spec_helper'

[ :maximum, :max ].each do |method|
  describe Aggregate::Maximum::Methods, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { Class.new { include Aggregate::Maximum::Methods } }
    let(:object)          { described_class.new.freeze                        }

    it { should be_kind_of(Aggregate::Maximum) }

    its(:operand) { should equal(object) }
  end
end
