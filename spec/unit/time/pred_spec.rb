require 'spec_helper'

describe 'Time#pred' do
  subject { object.pred }

  let(:klass)  { Time      }
  let(:object) { klass.now }

  it { should be_kind_of(klass) }

  it 'returns the time 1 second ago' do
    should == (object - 1)
  end

  it 'is the inverse of #succ' do
    subject.succ.should == object
  end
end
