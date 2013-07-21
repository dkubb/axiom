# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#functions' do
  subject { object.functions }

  let(:attribute) { Attribute::Integer.new(:id)                                              }
  let(:header)    { Relation::Header.new([attribute])                                        }
  let(:function)  { proc {}                                                                  }
  let(:object)    { described_class.new(header) { |object| object.add(attribute, function) } }

  it { should == { attribute => function } }

  it { should be_frozen }
end
