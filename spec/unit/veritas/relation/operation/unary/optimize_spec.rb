require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#optimize' do
  subject { unary_operation.optimize }

  describe 'with an empty relation' do
    let(:empty)           { Relation::Empty.new([ [ :id, Integer ] ]) }
    let(:unary_operation) { UnaryOperationSpecs::Object.new(empty)    }

    it { should equal(empty) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == unary_operation
    end
  end

  describe 'with an non-empty relation' do
    let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
    let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

    it 'attempts to delegate to the superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end

  describe 'with an optimizable relation' do
    let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
    let(:projection)      { relation.project(relation.header)             }
    let(:unary_operation) { UnaryOperationSpecs::Object.new(projection)   }

    it { should_not equal(unary_operation) }

    it { should be_instance_of(UnaryOperationSpecs::Object) }

    its(:relation) { should equal(relation) }
  end
end
