# encoding: utf-8

require 'spec_helper'

describe Date, '#pred' do
  subject { object.pred }

  let(:object) { described_class.today }

  it { should be_kind_of(described_class) }

  it 'returns the date 1 day ago' do
    should == (object - 1)
  end

  it 'is the inverse of #succ' do
    subject.succ.should == object
  end
end
