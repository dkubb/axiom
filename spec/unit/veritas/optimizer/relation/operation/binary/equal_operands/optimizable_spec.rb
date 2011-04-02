require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::EqualOperands, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class)  { Class.new(Optimizer::Relation::Operation::Binary) }
  let(:relation)         { mock('Relation', :left => left, :right => right)  }
  let(:materialized)     { mock('Materialized')                              }
  let(:not_materialized) { mock('Not Materialized')                          }
  let(:object)           { described_class.new(relation)                     }

  before do
    described_class.class_eval { include superclass::EqualOperands }
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
