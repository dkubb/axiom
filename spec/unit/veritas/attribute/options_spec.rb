# encoding: utf-8

require 'spec_helper'

describe Attribute, '#options' do
  subject { object.options }

  let(:described_class) { Class.new(Attribute) }

  context 'when no options are provided' do
    let(:object) { described_class.new(:name) }

    it { should be_instance_of(Hash) }

    it { should be_empty }

    it { should be_frozen }
  end

  context 'when options are frozen' do
    let(:options) { {}.freeze                           }
    let(:object)  { described_class.new(:name, options) }

    it { should equal(options) }
  end

  context 'when options are not frozen' do
    let(:options) { {}                                  }
    let(:object)  { described_class.new(:name, options) }

    it { should_not equal(options) }

    it { should be_instance_of(Hash) }

    it { should == options }

    it { should be_frozen }
  end
end
