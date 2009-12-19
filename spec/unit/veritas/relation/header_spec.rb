require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#header' do
  before do
    @header = [ [ :id, Integer ] ]
  end

  subject { Relation.new(@header, [ [ 1 ] ]).header }

  it { should == @header }
end
