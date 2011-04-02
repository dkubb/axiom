require 'spec_helper'

describe Logic::Proposition::True, '#inspect' do
  subject { object.inspect }

  let(:klass)  { Logic::Proposition::True }
  let(:object) { klass.instance           }

  it { should == 'true' }
end
