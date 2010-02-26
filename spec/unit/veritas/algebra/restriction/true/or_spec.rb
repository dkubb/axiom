require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::True#or' do
  before do
    @other = mock('other')

    @true = Algebra::Restriction::True.instance
  end

  subject { @true.or(@other) }

  it { should equal(@true) }
end
