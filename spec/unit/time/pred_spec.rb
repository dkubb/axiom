require File.expand_path('../../../spec_helper', __FILE__)

describe 'Time#pred' do
  subject { time.pred }

  let(:time) { Time.now }

  it 'returns the time 1 second ago' do
    should == (time - 1)
  end

  it 'is the inverse of #succ' do
    subject.succ.should == time
  end
end
