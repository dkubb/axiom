require 'spec_helper'

describe Evaluator::Expression, '#[]' do
  subject { object[name] }

  let(:name)      { :id                              }
  let(:attribute) { Attribute::Integer.new(name)     }
  let(:relation)  { Relation.new([ attribute ], [])  }
  let(:object)    { described_class.new(relation) {} }

  it { should equal(attribute) }
end
