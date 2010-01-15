require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#directions' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [])
  end

  subject { @relation.directions }

  it { should be_empty }

  it 'should be consistent' do
    should equal(@relation.directions)
  end
end
