require 'spec_helper'

describe 'Date#pred' do
  subject { date.pred }

  let(:date) { Date.today }

  it 'returns the date 1 day ago' do
    should == (date - 1)
  end

  it 'is the inverse of #succ' do
    subject.succ.should == date
  end
end
