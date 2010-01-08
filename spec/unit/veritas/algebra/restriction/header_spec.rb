require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#header' do
  before do
    @relation  = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @predicate = @relation[:id].eq(1)

    @restriction = Algebra::Restriction.new(@relation, @predicate)
  end

  subject { @restriction.header }

  it { should be_kind_of(Relation::Header) }

  it { should equal(@relation.header) }
end
