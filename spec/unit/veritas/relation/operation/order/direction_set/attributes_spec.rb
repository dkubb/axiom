# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#attributes' do
  subject { object.attributes }

  let(:attribute) { Attribute::Integer.new(:id)        }
  let(:object)    { described_class.new([ attribute ]) }

  it { should be_kind_of(Array) }

  it { should == [ attribute ] }
end
