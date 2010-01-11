require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#header' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @aliases  = { :id => :other_id }

    @rename = Algebra::Rename.new(@relation, @aliases)
  end

  subject { @rename.header }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :other_id, Integer ] ] }
end
