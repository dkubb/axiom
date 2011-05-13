# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#functions' do
  subject { object.functions }

  let(:attribute) { Attribute::Integer.new(:id)                                      }
  let(:relation)  { Relation.new([ attribute ], [])                                  }
  let(:function)  { mock('Function')                                                 }
  let(:object)    { described_class.new(relation) { |o| o.add(attribute, function) } }

  it { should == { attribute => function } }

  it { should be_frozen }
end
