require 'spec_helper'

describe Logic::Proposition::False, '#inspect' do
  subject { object.inspect }

  let(:object) { described_class.instance }

  it { should == 'false' }
end
