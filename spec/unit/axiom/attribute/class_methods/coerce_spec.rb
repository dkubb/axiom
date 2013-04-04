# encoding: utf-8

require 'spec_helper'

describe Attribute, '.coerce' do
  subject { object.coerce(argument) }

  let(:object) { described_class }

  context 'when the argument is an Attribute' do
    let(:argument) { Attribute::Integer.new(:id) }

    it { should equal(argument) }
  end

  context 'when the argument responds to #to_ary and does not include options' do
    let(:argument) { [ :id, Integer ] }

    it { should be_instance_of(Attribute::Integer) }

    its(:name) { should == :id }
  end

  context 'when the argument responds to #to_ary and includes options' do
    let(:argument) { [ :id, Integer, { :required => false } ] }

    it { should be_instance_of(Attribute::Integer) }

    its(:name) { should == :id }

    its(:required?) { should be(false) }
  end

  context 'when the argument does not respond to #to_ary, but does respond to #to_sym' do
    let(:argument) { :id }

    it { should be_instance_of(Attribute::Object) }

    its(:name) { should == :id }
  end

  context 'when the argument does not respond to #to_ary or #to_sym' do
    let(:argument) { Integer }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end

describe Attribute::Boolean, '.coerce' do
  subject { object.coerce(argument) }

  let(:object) { described_class }

  context 'when the argument is an Attribute' do
    let(:argument) { Attribute::Integer.new(:id) }

    it { should equal(argument) }
  end

  context 'when the argument responds to #to_ary and does not include options' do
    let(:argument) { [ :id, Integer ] }

    it { should be_instance_of(Attribute::Integer) }

    its(:name) { should == :id }
  end

  context 'when the argument responds to #to_ary and includes options' do
    let(:argument) { [ :id, Integer, { :required => false } ] }

    it { should be_instance_of(Attribute::Integer) }

    its(:name) { should == :id }

    its(:required?) { should be(false) }
  end

  context 'when the argument does not respond to #to_ary, but does respond to #to_sym' do
    let(:argument) { :id }

    it { should be_instance_of(described_class) }

    its(:name) { should == :id }
  end

  context 'when the argument does not respond to #to_ary or #to_sym' do
    let(:argument) { Integer }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
