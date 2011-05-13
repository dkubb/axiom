# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#[]' do
  subject { object[name] }

  let(:name)      { :id                              }
  let(:attribute) { Attribute::Integer.new(name)     }
  let(:relation)  { Relation.new([ attribute ], [])  }
  let(:object)    { described_class.new(relation) {} }

  it { should equal(attribute) }
end
