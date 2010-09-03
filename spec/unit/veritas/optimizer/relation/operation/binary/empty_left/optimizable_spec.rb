require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Binary::EmptyLeft#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Class.new(Optimizer::Relation::Operation::Binary) }
  let(:relation) { mock('Relation', :left => left, :right => right)  }
  let(:right)    { mock('Right')                                     }
  let(:object)   { klass.new(relation)                               }

  before do
    klass.class_eval { include superclass::EmptyLeft }
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
