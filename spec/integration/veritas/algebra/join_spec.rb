require 'spec_helper'

describe 'Veritas::Algebra::Join' do
  context 'Commutative property' do
    subject { left.join(right) }

    let(:left)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])                                             }
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ]) }

    it 'does not matter which order the relations are joined in' do
      should == right.join(left)
    end
  end
end
