require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::True#and' do
  before do
    @other = mock('other')

    @true = Algebra::Restriction::True.instance
  end

  subject { @true.and(@other) }

  it { should equal(@other) }
end
