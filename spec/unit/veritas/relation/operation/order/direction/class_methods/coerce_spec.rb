# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Direction, '.coerce' do
  subject { object.coerce(argument) }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { Class.new(described_class)  }

  context 'when the argument is a Direction' do
    let(:argument) { Relation::Operation::Order::Ascending.new(attribute) }

    it { should equal(argument) }
  end

  context 'when the argument is an Attribute' do
    let(:argument) { attribute }

    it { should be_instance_of(object) }

    its(:attribute) { should equal(attribute) }
  end
end
