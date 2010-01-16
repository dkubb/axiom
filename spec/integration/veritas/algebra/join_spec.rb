require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join' do
  describe 'Commutative property' do
    before do
      @left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
      @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ])
    end

    it 'should not matter which order the relations are joined in' do
      @left.join(@right).should eql(@right.join(@left))
    end
  end
end
