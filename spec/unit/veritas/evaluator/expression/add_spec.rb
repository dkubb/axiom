require 'spec_helper'

describe 'Veritas::Evaluator::Expression#add' do
  subject { klass.new(&expression) }

  let(:klass)     { Veritas::Evaluator::Expression }
  let(:attribute) { Attribute::Integer.new(:id)    }

  context 'when a function is provided' do
    let(:function)   { mock('Function')                          }
    let(:expression) { lambda { |o| o.add(attribute, function) } }

    its(:expressions) { should == { attribute => function } }
  end

  context 'when a block is provided' do
    let(:block)      { proc {}                                 }
    let(:expression) { lambda { |o| o.add(attribute, &block) } }

    its(:expressions) { should == { attribute => block } }
  end
end
