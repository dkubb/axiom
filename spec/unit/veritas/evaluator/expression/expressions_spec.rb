require 'spec_helper'

describe Evaluator::Expression, '#expressions' do
  subject { object.expressions }

  let(:attribute) { Attribute::Integer.new(:id)                            }
  let(:function)  { mock('Function')                                       }
  let(:object)    { described_class.new { |o| o.add(attribute, function) } }

  it { should == { attribute => function } }

  it { should be_frozen }
end
