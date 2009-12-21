require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join#header' do
  before do
    @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])
    @right = Relation.new([ [ :id,   Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
  end

  subject { Algebra::Join.new(@left, @right).header }

  it 'should join the headers' do
    should == [ [ :id, Integer ], [ :name, String ] ]
  end
end
