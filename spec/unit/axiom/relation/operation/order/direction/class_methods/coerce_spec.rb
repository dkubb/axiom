# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Direction, '.coerce' do
  subject { object.coerce(argument) }

  let(:object)    { Class.new(described_class)  }
  let(:attribute) { Attribute::Integer.new(:id) }

  context 'when the argument is a Direction' do
    let(:argument) { Relation::Operation::Order::Ascending.new(attribute) }

    it { should be(argument) }
  end

  context 'when the argument is an Attribute' do
    let(:argument) { attribute }

    it { should be_instance_of(object) }

    its(:attribute) { should be(attribute) }
  end

  context 'when the argument is an Array' do
    let(:argument) { [:id, Integer] }

    it { should be_instance_of(object) }

    its(:attribute) { should eql(attribute) }
  end
end
