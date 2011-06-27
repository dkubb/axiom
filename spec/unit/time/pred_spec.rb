# encoding: utf-8

require 'spec_helper'

describe Time, '#pred' do
  subject { object.pred }

  let(:object) { described_class.now }

  it { should be_instance_of(described_class) }

  it 'returns the time 1 second ago' do
    should eql(object - 1)
  end

  it 'is the inverse of #succ' do
    subject.succ.should eql(object)
  end
end
