require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::CombineOperation#header' do
  before do
    @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])
    @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])
  end

  subject { CombineOperationSpecs::Object.new(@left, @right).header }

  it 'should union the headers' do
    should == [ [ :id, Integer ], [ :name, String ] ]
  end
end
