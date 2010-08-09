require 'spec_helper'

describe 'Veritas::Attribute#options' do
  subject { attribute.options }

  let(:name)      { :id                                   }
  let(:attribute) { Attribute::Integer.new(name, options) }

  context 'when no options are provided' do
    let(:attribute) { Attribute::Integer.new(name) }

    it { should eql({}) }

    it { should be_frozen }
  end

  context 'when options are frozen' do
    let(:options) { {}.freeze }

    it { should equal(options) }
  end

  context 'when options are not frozen' do
    let(:options) { {} }

    it { should_not equal(options) }

    it { should eql(options) }

    it { should be_frozen }
  end
end
