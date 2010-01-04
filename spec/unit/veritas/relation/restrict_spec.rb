require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#restrict' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @relation.restrict {} }

  it { should be_kind_of(Algebra::Restriction) }
end
