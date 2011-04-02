require 'spec_helper'

describe Algebra::Product do
  context 'Commutative property' do
    subject { left.product(right) }

    let(:left)  { Relation.new([ [ :id,   Integer ] ], [ [ 1 ], [ 2 ] ])                    }
    let(:right) { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ], [ 'Alex Kubb' ] ]) }

    it 'does not matter which order the relations are multiplied in' do
      should == right.product(left)
    end
  end
end
