require 'spec_helper'

describe Optimizer::Algebra::Product::TableDeeLeft, '#optimize' do
  subject { object.optimize }

  let(:left)     { TABLE_DEE                                           }
  let(:right)    { Relation.new([ [ :id, Integer  ] ], [ [ 1 ] ].each) }
  let(:relation) { left.product(right)                                 }
  let(:object)   { described_class.new(relation)                       }

  before do
    object.should be_optimizable
  end

  it { should equal(right) }
end
