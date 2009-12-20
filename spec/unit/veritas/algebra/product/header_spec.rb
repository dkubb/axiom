require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#header' do
  before do
    @left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @right = Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ])
  end

  subject { Algebra::Product.new(@left, @right).header }

  it 'should join the headers' do
    should == [ [ :id, Integer ], [ :name, String ] ]
  end
end
