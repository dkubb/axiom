require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::False#and' do
  before do
    @other = mock('other')

    @false = Algebra::Restriction::False.instance
  end

  subject { @false.and(@other) }

  it { should equal(@false) }
end
