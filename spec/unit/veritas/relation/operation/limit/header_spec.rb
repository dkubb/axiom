require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#header' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @ordered  = @relation.order { |r| r[:id] }

    @limit = Relation::Operation::Limit.new(@ordered, 1)
  end

  subject { @limit.header }

  it { should equal(@ordered.header) }
end
