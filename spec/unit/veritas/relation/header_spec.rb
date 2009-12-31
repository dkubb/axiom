require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#header' do
  before do
    @header = [ [ :id, Integer ] ]

    @relation = Relation.new(@header, [ [ 1 ] ])
  end

  subject { @relation.header }

  it { should be_kind_of(Relation::Header) }

  it { should == @header }
end
