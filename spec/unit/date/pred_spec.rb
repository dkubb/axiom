require 'spec_helper'

describe 'Date#pred' do
  subject { object.pred }

  let(:klass)  { Date        }
  let(:object) { klass.today }

  it { should be_kind_of(klass) }

  it 'returns the date 1 day ago' do
    should == (object - 1)
  end

  it 'is the inverse of #succ' do
    subject.succ.should == object
  end
end
