require 'spec_helper'

describe Aggregate, '#default' do
  subject { object.default }

  let(:described_class) { Class.new(Aggregate)           }
  let(:object)          { described_class.new(attribute) }
  let(:attribute)       { Attribute::Integer.new(:id)    }

  it 'delegates to self.class.default' do
    return_value = mock('Return Value')
    described_class.should_receive(:default).with(no_args).and_return(return_value)
    should equal(return_value)
  end
end
