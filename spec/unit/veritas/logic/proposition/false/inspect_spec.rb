require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#inspect' do
  before do
    @false = Logic::Proposition::False.instance
  end

  subject { @false.inspect }

  it { should == 'false' }
end
