require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product' do
  describe 'Commutative property' do
    let(:left)  { Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])                    }
    let(:right) { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ], [ 'Alex Kubb' ] ]) }

    subject { left.product(right) }

    it 'does not matter which order the relations are multiplied in' do
      should == right.product(left)
    end

    it { should have_tuples_matching_predicate }
  end
end
