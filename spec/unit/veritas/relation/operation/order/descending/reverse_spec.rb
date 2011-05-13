# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Descending, '#reverse' do
  subject { object.reverse }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:object)    { described_class.new(attribute) }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }

  its(:attribute) { should equal(attribute) }
end
