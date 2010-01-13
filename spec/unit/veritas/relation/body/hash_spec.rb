require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#hash' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])

    @body = Relation::Body.new([ [ 1 ] ], @header)
  end

  subject { @body.hash }

  it { should be_kind_of(Integer) }

  it { should == @body.to_set.hash }
end
