require 'spec_helper'

describe Evaluator::Expression, '#expressions' do
  subject { object.expressions }

  let(:attribute) { Attribute::Integer.new(:id)                                      }
  let(:relation)  { Relation.new([ attribute ], [])                                  }
  let(:function)  { mock('Function')                                                 }
  let(:object)    { described_class.new(relation) { |o| o.add(attribute, function) } }

  it { should == { attribute => function } }

  it { should be_frozen }
end
