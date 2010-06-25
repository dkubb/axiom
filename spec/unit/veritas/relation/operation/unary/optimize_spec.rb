require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#optimize' do
  subject { unary_operation.optimize }

  let(:klass) { Class.new(UnaryOperationSpecs::Object) }

  context 'with an empty relation' do
    let(:empty)           { Relation::Empty.new([ [ :id, Integer ] ]) }
    let(:unary_operation) { klass.new(empty)                          }

    it { should equal(empty) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == unary_operation
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an non-empty relation' do
    let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
    let(:unary_operation) { klass.new(relation)                           }

    it 'attempts to delegate to the superclass' do
      expect { subject }.to raise_error(NoMethodError)
    end
  end

  context 'with an optimizable relation' do
    let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
    let(:projection)      { relation.project(relation.header)             }
    let(:unary_operation) { klass.new(projection)                         }

    add_method_missing

    it { should_not equal(unary_operation) }

    it { should be_instance_of(klass) }

    its(:relation) { should equal(relation) }

    it_should_behave_like 'an optimize method'
  end
end
