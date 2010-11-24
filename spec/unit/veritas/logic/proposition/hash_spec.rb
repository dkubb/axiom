require 'spec_helper'

describe 'Veritas::Logic::Proposition#hash' do
  subject { object.hash }

  let(:klass)  { Class.new(Logic::Proposition) }
  let(:object) { klass.new                     }

  it_should_behave_like 'an idempotent method'

  it 'hashes the results of self.class' do
    should == klass.hash
  end
end
