require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#or' do
  before do
    @other = mock('other')

    @false = Logic::Proposition::False.instance
  end

  subject { @false.or(@other) }

  it { should equal(@other) }
end
