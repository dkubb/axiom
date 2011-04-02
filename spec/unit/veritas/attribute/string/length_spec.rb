require 'spec_helper'

[ :length, :range ].each do |method|
  describe Attribute::String, "##{method}" do
    subject { object.send(method) }

    context 'without :length option passed to constructor' do
      let(:object) { described_class.new(:name) }

      it { should == (0..50) }
    end

    context 'with :length option passed to constructor' do
      let(:length) { 1..100                                        }
      let(:object) { described_class.new(:name, :length => length) }

      it { should == length }
    end
  end
end
