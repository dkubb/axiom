# encoding: utf-8

require 'spec_helper'

describe Attribute, '#name' do
  subject { object.name }

  let(:described_class) { Class.new(Attribute)      }
  let(:object)          { described_class.new(name) }

  context 'when name is a Symbol' do
    let(:name) { :name }

    it { should equal(name) }
  end

  context 'when name is a String' do
    let(:name) { 'name' }

    it { should be_instance_of(Symbol) }

    it { should == :name }
  end
end
