require 'spec_helper'

describe Evaluator::Expression, '#add' do
  let(:attribute) { Attribute::Integer.new(:id) }

  context 'when a function is provided' do
    subject { described_class.new { |object| object.add(attribute, function) } }

    let(:function) { mock('Function') }

    its(:expressions) { should == { attribute => function } }
  end

  context 'when a block is provided' do
    subject { described_class.new { |object| object.add(attribute, &block) } }

    let(:block) { proc {} }

    its(:expressions) { should == { attribute => block } }
  end
end
