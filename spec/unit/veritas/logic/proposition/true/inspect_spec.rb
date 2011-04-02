require 'spec_helper'

describe Logic::Proposition::True, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.instance }

  it { should == 'true' }
end
