require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Combine#header' do
  before do
    @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])
    @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])

    @combine_operation = CombineOperationSpecs::Object.new(@left, @right)
  end

  subject { @combine_operation.header }

  it { should be_kind_of(Relation::Header) }

  it 'unions the headers' do
    should == [ [ :id, Integer ], [ :name, String ] ]
  end
end
