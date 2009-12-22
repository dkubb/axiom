require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join#body' do
  before do
    @left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])
  end

  subject { Algebra::Join.new(@left, @right).body }

  it 'should be the concatenation of the bodies on the common attributes' do
    should == [ [ 2, 'Dan Kubb' ] ]
  end
end
