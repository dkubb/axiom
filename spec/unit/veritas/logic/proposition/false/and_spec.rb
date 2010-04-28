require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Proposition::False#and' do
  before do
    @other = mock('other')

    @false = Logic::Proposition::False.instance
  end

  subject { @false.and(@other) }

  it { should equal(@false) }
end
