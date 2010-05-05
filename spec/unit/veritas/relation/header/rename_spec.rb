require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#rename' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
  end

  subject { @header.rename(:id => :other_id) }

  it { should be_kind_of(Relation::Header) }

  it { should_not equal(@header) }

  its(:to_ary) { should == [ [ :other_id, Integer ], [ :name, String ] ] }
end
