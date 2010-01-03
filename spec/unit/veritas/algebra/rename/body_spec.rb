require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#body' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @aliases  = { :id => :other_id }

    @rename = Algebra::Rename.new(@relation, @aliases)
  end

  subject { @rename.body }

  it { should be_kind_of(Relation::Body) }

  it { should == [ [ 1 ] ] }

  it { subject.header.should equal(@rename.header) }
end
