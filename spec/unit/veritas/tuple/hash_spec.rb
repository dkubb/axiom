require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#hash' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])
  end

  subject { @tuple.hash }

  it { should be_kind_of(Integer) }

  it { should == @header.hash ^ [ 1 ].hash }
end
