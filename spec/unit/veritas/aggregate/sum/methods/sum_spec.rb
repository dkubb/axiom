require 'spec_helper'

describe Aggregate::Sum::Methods, '#sum' do
  subject { object.sum }

  let(:described_class) { Class.new { include Aggregate::Sum::Methods } }
  let(:object)          { described_class.new.freeze                    }

  it { should be_kind_of(Aggregate::Sum) }

  its(:operand) { should == object }
end
