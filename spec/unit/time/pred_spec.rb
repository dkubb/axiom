require File.expand_path('../../../spec_helper', __FILE__)

describe 'Time#pred' do
  before do
    @time = Time.now
  end

  subject { @time.pred }

  it 'should return the time 1 second ago' do
    should == (@time - 1)
  end

  it 'should be the inverse of #succ' do
    subject.succ.should == @time
  end
end
