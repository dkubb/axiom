require 'spec_helper'

describe 'Veritas::Logic::Proposition#call' do
  subject { object.call }

  let(:klass)  { Class.new(Logic::Proposition) }
  let(:object) { klass.new                     }

  it 'calls self.class.call' do
    response = mock('#call response')
    klass.should_receive(:call).and_return(response)
    should equal(response)
  end
end
