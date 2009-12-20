require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#body' do
  before do
    @left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @right = Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ])
  end

  subject { Algebra::Product.new(@left, @right).body }

  it 'should be the product of the bodies' do
    should == [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ] ]
  end
end
