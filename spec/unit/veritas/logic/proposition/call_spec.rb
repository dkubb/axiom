require 'spec_helper'

describe Logic::Proposition, '#call' do
  subject { object.call }

  let(:described_class) { Class.new(Logic::Proposition) }
  let(:object)          { described_class.new           }

  it 'calls self.class.call' do
    response = mock('#call response')
    described_class.should_receive(:call).and_return(response)
    should equal(response)
  end
end
