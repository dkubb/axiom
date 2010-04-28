require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#predicate' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
  end

  subject { @relation.predicate }

  it { should equal(Logic::Proposition::True.instance) }
end
