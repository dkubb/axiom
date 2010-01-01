require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#to_ary' do
  before do
    @attribute = [ :id, Integer ]
    @header    = Relation::Header.new([ @attribute ])
  end

  subject { @header.to_ary }

  it { should be_kind_of(Array) }

  it { should == [ @attribute ] }
end
