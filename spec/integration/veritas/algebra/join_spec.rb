require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join' do
  describe 'Commutative property' do
    before do
      @left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
      @right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ])
    end

    subject { @left.join(@right) }

    it 'should not matter which order the relations are joined in' do
      should == @right.join(@left)
    end

    it { should have_tuples_matching_predicate }
  end
end
