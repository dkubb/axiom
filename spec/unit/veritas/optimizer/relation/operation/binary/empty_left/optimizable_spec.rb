require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::EmptyLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer::Relation::Operation::Binary) }
  let(:relation)        { mock('Relation', :left => left, :right => right)  }
  let(:right)           { mock('Right')                                     }
  let(:object)          { described_class.new(relation)                     }

  before do
    described_class.class_eval { include superclass::EmptyLeft }
  end

  before do
    right.stub!(:optimize).and_return(right)
  end

  context 'when left is empty' do
    let(:left) { Relation::Empty.new([ [ :id, Integer ] ]) }

    it { should be(true) }
  end

  context 'when left is not empty' do
    let(:left) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

    it { should be(false) }
  end
end
