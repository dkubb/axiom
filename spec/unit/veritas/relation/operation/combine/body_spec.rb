require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Combine#body' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])

    @left  = Relation.new(@header, [ [ 1 ] ])
    @right = Relation.new(@header, [ [ 2 ] ])

    @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
  end

  subject { @combine_operation.body }

  it 'should return the expected body' do
    should == [ [ 1 ], [ 2 ] ]
  end
end
