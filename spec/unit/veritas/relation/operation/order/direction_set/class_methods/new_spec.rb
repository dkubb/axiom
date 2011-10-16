# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '.new' do
  subject { object.new(argument) }

  let(:id)     { Attribute::Integer.new(:id)  }
  let(:name)   { Attribute::String.new(:name) }
  let(:age)    { Attribute::Integer.new(:age) }
  let(:object) { described_class              }

  context 'with an argument that responds to #to_ary and do not contain duplicates' do
    let(:argument) { [ id, name ] }

    it { should be_instance_of(object) }

    it { should == argument }
  end

  context 'with an argument that responds to #to_ary and contain duplicates' do
    let(:argument) { [ id, id, name, name, age ] }

    specify { expect { subject }.to raise_error(DuplicateNameError, 'duplicate names: id, name') }
  end

  context 'with an argument that does not respond to #to_ary' do
    let(:argument) { { :id => Integer } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
