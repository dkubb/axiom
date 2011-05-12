require 'spec_helper'

describe Attribute::String, '#max_length' do
  subject { object.max_length }

  context 'without :max_length option passed to constructor' do
    let(:object) { described_class.new(:name) }

    it { should == 50 }
  end

  context 'with :length option passed to constructor' do
    let(:max_length) { 100                                                   }
    let(:object)     { described_class.new(:name, :max_length => max_length) }

    it { should == max_length }
  end
end
