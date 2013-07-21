# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '#hash' do
  subject { object.hash }

  let(:operand)    { Relation.new([[:id, Integer]], [[1], [2]])           }
  let(:directions) { described_class::DirectionSet.coerce(operand.header) }
  let(:object)     { described_class.new(operand, directions)             }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash ^ directions.hash }
end
