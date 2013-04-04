# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#hash' do
  subject { object.hash }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:directions) { [ attribute.asc ]               }
  let(:object)     { described_class.new(directions) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ directions.hash }
end
