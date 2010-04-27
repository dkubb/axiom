require File.expand_path('../../../spec_helper', __FILE__)

describe 'Date#pred' do
  before do
    @date = Date.today
  end

  subject { @date.pred }

  it 'returns the date 1 day ago' do
    should == (@date - 1)
  end

  it 'is the inverse of #succ' do
    subject.succ.should == @date
  end
end
