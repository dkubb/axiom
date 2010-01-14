require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#offset' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @ordered  = @relation.order { |r| r[:id] }
  end

  subject { @ordered.offset(1) }

  it { should be_kind_of(Relation::Operation::Offset) }
end
