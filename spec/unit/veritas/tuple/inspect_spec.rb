require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#inspect' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])
  end

  subject { @tuple.inspect }

  it { should be_kind_of(String) }

  it { should == '[1]' }
end
