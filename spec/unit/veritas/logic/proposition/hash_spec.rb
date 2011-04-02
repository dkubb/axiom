require 'spec_helper'

describe Logic::Proposition, '#hash' do
  subject { object.hash }

  let(:klass)  { Class.new(Logic::Proposition) }
  let(:object) { klass.new                     }

  it_should_behave_like 'a hash method'

  it { should == klass.hash }
end
