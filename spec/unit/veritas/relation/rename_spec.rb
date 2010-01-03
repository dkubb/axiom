require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#rename' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @relation.rename(:id => :other_id) }

  it { should be_kind_of(Algebra::Rename) }
end
