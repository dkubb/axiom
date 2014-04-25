# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Sorted::Descending, '#reverse' do
  subject { object.reverse }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:object)    { described_class.new(attribute) }

  it { should be_instance_of(Relation::Operation::Sorted::Ascending) }

  its(:attribute) { should be(attribute) }
end
