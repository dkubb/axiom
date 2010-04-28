require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#inspect' do
  before do
    @true = Logic::Proposition::True.instance
  end

  subject { @true.inspect }

  it { should == 'true' }
end
