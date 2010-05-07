require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Combine#optimize' do
  let(:original_left)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])                         }
  let(:original_right)    { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }
  let(:combine_operation) { CombineOperationSpecs::Object.new(left, right)                               }

  subject { combine_operation.optimize }

  context 'left is an empty relation' do
    let(:left)  { Relation::Empty.new(original_left.header) }
    let(:right) { original_right                            }

    it 'attempts to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  context 'right is an empty relation' do
    let(:left)  { original_left                              }
    let(:right) { Relation::Empty.new(original_right.header) }

    it 'attempts to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  context 'left is an empty relation when optimized' do
    let(:left)  { Algebra::Restriction.new(original_left, Logic::Proposition::False.instance) }
    let(:right) { original_right                                                              }

    it 'attempts to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  context 'right is an empty relation when optimized' do
    let(:left)  { original_left                                                                }
    let(:right) { Algebra::Restriction.new(original_right, Logic::Proposition::False.instance) }

    it 'attempts to delegate new_empty_relation' do
      method(:subject).should raise_error(NotImplementedError, 'CombineOperationSpecs::Object#new_empty_relation')
    end
  end

  context 'left and right are not empty relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it 'attempts to delegate to the superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end
end
