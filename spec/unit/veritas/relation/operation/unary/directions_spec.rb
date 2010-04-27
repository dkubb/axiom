require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#directions' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])

    @unary_operation = UnaryOperationSpecs::Object.new(@relation)
  end

  subject { @unary_operation.directions }

  it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

  it { should equal(@relation.directions) }

  it 'is consistent' do
    should equal(@unary_operation.directions)
  end
end
