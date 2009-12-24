require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product' do
  describe 'Commutative property' do
    before do
      @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])
      @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])
    end

    it 'should not matter which order the relations are multiplied in' do
      pending 'Relation should be comparable even if the header order is different' do
        @left.product(@right).should eql(@right.product(@left))
      end
    end
  end
end
