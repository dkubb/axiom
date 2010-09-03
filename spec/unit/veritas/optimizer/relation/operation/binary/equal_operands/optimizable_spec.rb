require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Binary::EqualOperands#optimizable?' do
  subject { object.optimizable? }

  let(:klass)            { Class.new(Optimizer::Relation::Operation::Binary) }
  let(:relation)         { mock('Relation', :left => left, :right => right)  }
  let(:materialized)     { mock('Materialized')                              }
  let(:not_materialized) { mock('Not Materialized')                          }
  let(:object)           { klass.new(relation)                               }

  before do
    klass.class_eval { include superclass::EqualOperands }
  end

  before do
    left.stub!(:optimize).and_return(left)
    right.stub!(:optimize).and_return(right)
  end

  context 'when left and right are equal' do
    let(:left)  { not_materialized }
    let(:right) { not_materialized }

    it { should be(true) }
  end

  context 'when left and right are not equal' do
    let(:left)  { not_materialized }
    let(:right) { materialized     }

    it { should be(false) }
  end
end
