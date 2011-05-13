# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '#empty?' do
  subject { object.empty? }

  let(:object) { described_class.new(attributes) }

  context 'with an empty set' do
    let(:attributes) { [] }

    it { should be(true) }
  end

  context 'with directions' do
    let(:attributes) { [ Attribute::Integer.new(:id) ] }

    it { should be(false) }
  end
end
