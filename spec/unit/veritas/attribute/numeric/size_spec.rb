# encoding: utf-8

require 'spec_helper'

[ :size, :range ].each do |method|
  describe Attribute::Numeric, "##{method}" do
    subject { object.send(method) }

    context 'without :size option passed to constructor' do
      let(:object) { described_class.new(:id) }

      it { should == (0..2**31-1) }
    end

    context 'with :size option passed to constructor' do
      let(:object) { described_class.new(:id, :size => 1..100) }

      it { should == (1..100) }
    end
  end
end
