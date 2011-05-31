# encoding: utf-8

require 'spec_helper'

[ :size, :range ].each do |method|
  describe Attribute::Float, "##{method}" do
    subject { object.send(method) }

    context 'without :size option passed to constructor' do
      let(:object) { described_class.new(:id) }

      it { should eql(-Float::MAX..Float::MAX) }
    end

    context 'with :size option passed to constructor' do
      let(:object) { described_class.new(:id, :size => 1.0..100.0) }

      it { should eql(1.0..100.0) }
    end
  end
end
