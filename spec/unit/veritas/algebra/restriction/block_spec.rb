require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#block' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @block    = lambda {}

    @restriction = Algebra::Restriction.new(@relation, &@block)
  end

  subject { @restriction.block }

  it { should equal(@block) }
end
