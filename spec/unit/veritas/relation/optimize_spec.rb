require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#optimize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @relation.optimize }

  it { should equal(@relation) }
end
