require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#relation' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @restriction = Algebra::Restriction.new(@relation) {}
  end

  subject { @restriction.relation }

  it { should equal(@relation) }
end
