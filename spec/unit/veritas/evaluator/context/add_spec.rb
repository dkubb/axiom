require 'spec_helper'

describe Evaluator::Context, '#add' do
  let(:attribute) { Attribute::Integer.new(:id)     }
  let(:relation)  { Relation.new([ attribute ], []) }

  context 'when a function is provided' do
    subject { described_class.new(relation) { |object| object.add(attribute, function) } }

    let(:function) { mock('Function') }

    its(:functions) { should == { attribute => function } }
  end

  context 'when a block is provided' do
    subject { described_class.new(relation) { |object| object.add(attribute, &block) } }

    let(:block) { proc {} }

    its(:functions) { should == { attribute => block } }
  end
end
