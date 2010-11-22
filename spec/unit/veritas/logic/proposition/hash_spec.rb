require 'spec_helper'

describe 'Veritas::Logic::Proposition#hash' do
  subject { object.hash }

  let(:klass)  { Class.new(Logic::Proposition) }
  let(:object) { klass.new                     }

  before do
    @response = mock('#call response')
    klass.should_receive(:call).at_least(:once).and_return(@response)
  end

  it_should_behave_like 'an idempotent method'

  it 'hashes the results of self.class.call' do
    should == @response.hash
  end
end
