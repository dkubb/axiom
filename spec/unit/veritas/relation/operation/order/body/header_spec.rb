require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Body#header' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = Relation::Operation::Order::DirectionSet.new([ @relation[:id].desc ])

    @body = Relation::Operation::Order::Body.new(@relation.body, @directions)
  end

  subject { @body.header }

  it { should equal(@relation.header) }
end
