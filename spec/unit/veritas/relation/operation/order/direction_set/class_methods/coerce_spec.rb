# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '.coerce' do
  subject { object.coerce(argument) }

  let(:directions)    { [ Attribute::Integer.new(:id) ] }
  let(:object)        { described_class                 }
  let(:direction_set) { object.new(directions)          }

  context 'when the argument is a DirectionSet' do
    let(:argument) { direction_set }

    it { should equal(argument) }
  end

  context 'when the argument responds to #to_ary' do
    let(:argument) { directions }

    it { should be_kind_of(object) }

    it { should == direction_set }
  end

  context 'when the argument is not a DirectionSet and does not respond to #to_ary' do
    let(:argument) { { :id => Integer } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
