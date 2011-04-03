require 'spec_helper'

describe Optimizer::Algebra::Product::TableDeeRight, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([ [ :id, Integer  ] ], [ [ 1 ] ].each) }
  let(:right)    { TABLE_DEE                                           }
  let(:relation) { left.product(right)                                 }
  let(:object)   { described_class.new(relation)                       }

  before do
    object.should be_optimizable
  end

  it { should equal(left) }
end
