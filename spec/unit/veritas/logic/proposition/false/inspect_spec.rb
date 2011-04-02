require 'spec_helper'

describe Logic::Proposition::False, '#inspect' do
  subject { object.inspect }

  let(:klass)  { Logic::Proposition::False }
  let(:object) { klass.instance            }

  it { should == 'false' }
end
