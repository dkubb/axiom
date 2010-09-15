require 'spec_helper'

describe 'Veritas::Evaluator::Expression#expressions' do
  subject { object.expressions }

  let(:klass)     { Veritas::Evaluator::Expression               }
  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:function)  { mock('Function')                             }
  let(:object)    { klass.new { |o| o.add(attribute, function) } }

  it { should == { attribute => function } }

  it { should be_frozen }
end
