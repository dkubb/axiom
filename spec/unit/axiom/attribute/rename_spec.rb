# encoding: utf-8

require 'spec_helper'

describe Attribute, '#rename' do
  subject { object.rename(name) }

  let(:described_class) { Class.new(Attribute)                        }
  let(:object)          { described_class.new(:name, required: false) }

  before do
    allow(described_class).to receive(:type).and_return(Types::Object)
  end

  context 'when the new name is the same' do
    let(:name) { object.name }

    it { should be(object) }
  end

  context 'when the new name is different' do
    let(:name) { :other_name }

    it { should be_instance_of(described_class) }

    it { should_not be(object) }

    its(:name) { should be(name) }

    its(:required?) { should be(false) }
  end
end
