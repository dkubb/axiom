require 'spec_helper'

describe Aggregate, '#finalize' do
  subject { object.finalize(accumulator) }

  let(:described_class) { Class.new(Aggregate)           }
  let(:object)          { described_class.new(attribute) }
  let(:attribute)       { Attribute::Integer.new(:id)    }
  let(:accumulator)     { mock('Accumulator')            }

  it 'delegates to self.class.finalize' do
    return_value = mock('Return Value')
    described_class.should_receive(:finalize).with(accumulator).and_return(return_value)
    should equal(return_value)
  end
end
