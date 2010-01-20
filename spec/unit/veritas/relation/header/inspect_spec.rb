require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#inspect' do
  before do
    @attribute = [ :id, Integer ]
    @header    = Relation::Header.new([ @attribute ])
  end

  subject { @header.inspect }

  it { should be_kind_of(String) }

  it { should == '[<Attribute::Integer name: id>]' }
end
