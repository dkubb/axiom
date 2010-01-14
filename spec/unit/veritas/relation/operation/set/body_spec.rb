require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Set#body' do
  before do
    @header = [ [ :id, Integer ] ]

    @left  = Relation.new(@header, [ [ 1 ] ])
    @right = Relation.new(@header, [ [ 2 ] ])

    @set_operation = SetOperationSpecs::Object.new(@left, @right)
  end

  subject { @set_operation.body }

  it { should be_kind_of(Relation::Body) }

  it 'should equal both relation bodies' do
    should == [ [ 1 ], [ 2 ] ]
  end
end
