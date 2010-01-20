require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::True#inspect' do
  before do
    @true = Algebra::Restriction::True.new
  end

  subject { @true.inspect }

  it { should == 'true' }
end
