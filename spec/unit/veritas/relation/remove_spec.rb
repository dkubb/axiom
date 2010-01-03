require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#remove' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
  end

  subject { @relation.remove([ :id ]) }

  it { should be_kind_of(Algebra::Project) }

  it { subject.header.should == [ [ :name, String ] ] }
end
