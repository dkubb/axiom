require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Body#header' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @body = Algebra::Restriction::Body.new(@relation, proc { true })
  end

  subject { @body.header }

  it { should equal(@relation.header) }
end
