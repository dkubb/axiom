require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#header' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])
  end

  subject { @tuple.header }

  it { should equal(@header) }
end
