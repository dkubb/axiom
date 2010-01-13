require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#hash' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])

    @body = Relation::Body.new([ [ 1 ] ], @header)
  end

  subject { @body.inspect }

  it { should be_kind_of(String) }

  it { should == '[[1]]' }
end
