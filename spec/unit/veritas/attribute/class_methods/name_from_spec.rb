require 'spec_helper'

describe Attribute, '.name_from' do
  subject { object.name_from(argument) }

  let(:object) { described_class }

  context 'argument is an Attribute' do
    let(:argument) { Attribute::Integer.new(:id) }

    it { should == :id }
  end

  context 'argument that responds to #to_ary' do
    let(:argument) { [ :id, Integer ] }

    it { should == :id }
  end

  context 'argument that responds to #to_sym' do
    let(:argument) { 'id' }

    it { should == :id }
  end

  context 'argument that is not an Attribute, does not respond to #to_ary or #to_sym' do
    let(:argument) { Object.new }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
