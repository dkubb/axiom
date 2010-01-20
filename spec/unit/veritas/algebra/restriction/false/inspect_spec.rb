require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::False#inspect' do
  before do
    @false = Algebra::Restriction::False.new
  end

  subject { @false.inspect }

  it { should == 'false' }
end
