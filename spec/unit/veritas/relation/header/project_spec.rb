require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#project' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
  end

  subject { @header.project([ :id ]) }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ] ] }
end
