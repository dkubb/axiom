require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#header' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @block    = lambda { |relation| relation[:id].eq(1) }

    @restriction = Algebra::Restriction.new(@relation, &@block)
  end

  subject { @restriction.header }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ] ] }
end
