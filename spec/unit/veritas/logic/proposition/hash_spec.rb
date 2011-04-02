require 'spec_helper'

describe Logic::Proposition, '#hash' do
  subject { object.hash }

  let(:described_class) { Class.new(Logic::Proposition) }
  let(:object)          { described_class.new           }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash }
end
