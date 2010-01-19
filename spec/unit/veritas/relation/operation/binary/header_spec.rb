require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#header' do
  before do
    @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])
    @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])

    @binary_operation = BinaryRelationOperationSpecs::Object.new(@left, @right)
  end

  subject { @binary_operation.header }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ], [ :name, String ] ] }
end
