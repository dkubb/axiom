require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::EmptyRight, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer::Relation::Operation::Binary) }
  let(:relation)        { mock('Relation', :left => left, :right => right)  }
  let(:left)            { mock('Left')                                      }
  let(:object)          { described_class.new(relation)                     }

  before do
    described_class.class_eval { include superclass::EmptyRight }
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
