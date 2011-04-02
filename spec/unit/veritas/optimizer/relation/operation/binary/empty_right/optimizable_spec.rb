require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::EmptyRight, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)    { Class.new(Optimizer::Relation::Operation::Binary) }
  let(:relation) { mock('Relation', :left => left, :right => right)  }
  let(:left)     { mock('Left')                                      }
  let(:object)   { klass.new(relation)                               }

  before do
    klass.class_eval { include superclass::EmptyRight }
  end

  before do
    left.stub!(:optimize).and_return(left)
  end

  context 'when right is empty' do
    let(:right) { Relation::Empty.new([ [ :id, Integer ] ]) }

    it { should be(true) }
  end

  context 'when right is not empty' do
    let(:right) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

    it { should be(false) }
  end
end
