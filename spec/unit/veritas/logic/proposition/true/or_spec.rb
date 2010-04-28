require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#or' do
  before do
    @other = mock('other')

    @true = Logic::Proposition::True.instance
  end

  subject { @true.or(@other) }

  it { should equal(@true) }
end
