require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Binary#optimize' do
  subject { binary_operation.optimize }

  let(:original_left)    { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
  let(:original_right)   { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
  let(:binary_operation) { BinaryRelationOperationSpecs::Object.new(left, right)    }

  context 'containing optimized relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it 'delegates to super, but no #optimize in superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end

  context 'containing optimizable relations' do
    let(:left)  { original_left.project(original_left.header)   }
    let(:right) { original_right.project(original_right.header) }

    it { should_not equal(binary_operation) }

    it { should_not eql(BinaryRelationOperationSpecs::Object.new(left, right)) }

    it { should eql(BinaryRelationOperationSpecs::Object.new(left.optimize, right.optimize)) }
  end
end
