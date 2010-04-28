require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::True#and' do
  before do
    @other = mock('other')

    @true = Logic::Proposition::True.instance
  end

  subject { @true.and(@other) }

  it { should equal(@other) }
end
