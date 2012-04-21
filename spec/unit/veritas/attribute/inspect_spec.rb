# encoding: utf-8

require 'spec_helper'

describe Attribute, '#inspect' do
  subject { object.inspect }

  let(:described_class) { Class.new(Attribute)       }
  let(:object)          { described_class.new(:name) }

  context 'when the class is named' do
    let(:name) { 'AttributeClass' }

    before do
      described_class.should_receive(:name).and_return(name)
    end

    it { should be_instance_of(String) }

    it { should == "<#{name} name: name>" }
  end

  context 'when the class is anonymous' do
    it { should be_instance_of(String) }

    it { should == "<#{described_class.inspect} name: name>" }
  end
end
