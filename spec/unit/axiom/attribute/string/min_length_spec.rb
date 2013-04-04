# encoding: utf-8

require 'spec_helper'

describe Attribute::String, '#min_length' do
  subject { object.min_length }

  context 'without :min_length option passed to constructor' do
    let(:object) { described_class.new(:name) }

    it { should == 0 }
  end

  context 'with :length option passed to constructor' do
    let(:min_length) { 1                                                     }
    let(:object)     { described_class.new(:name, :min_length => min_length) }

    it { should == min_length }
  end
end
