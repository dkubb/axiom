require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#hash' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [])
  end

  subject { @relation.hash }

  it { should be_kind_of(Integer) }

  it { should == @relation.header.hash ^ [].hash }
end
