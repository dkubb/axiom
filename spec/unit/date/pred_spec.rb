# encoding: utf-8

require 'spec_helper'

describe Date, '#pred' do
  subject { object.pred }

  let(:object) { described_class.today }

  it { should be_instance_of(described_class) }

  it 'returns the date 1 day ago' do
    should eql(object - 1)
  end

  it 'is the inverse of #succ' do
    expect(subject + 1).to eql(object)
  end
end
