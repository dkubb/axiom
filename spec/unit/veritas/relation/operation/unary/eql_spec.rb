require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Operation::Unary#eql?' do
  subject { unary_operation.eql?(other) }

  let(:relation)        { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:unary_operation) { UnaryOperationSpecs::Object.new(relation)     }

  context 'with the same unary operation' do
    let(:other) { unary_operation }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end

  context 'with an equivalent unary operation' do
    let(:other) { unary_operation.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end

  context 'with a different unary operation' do
    let(:other) { UnaryOperationSpecs::Other.new(relation) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end

  context 'with an equivalent unary operation of a different class' do
    let(:other) { Class.new(UnaryOperationSpecs::Object).new(relation) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(unary_operation)
    end
  end
end
