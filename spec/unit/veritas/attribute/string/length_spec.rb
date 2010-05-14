require 'spec_helper'

[ :length, :range ].each do |method|
  describe "Veritas::Attribute::String##{method}" do
    subject { attribute.send(method) }

    context 'without :length option passed to constructor' do
      let(:attribute) { Attribute::String.new(:name) }

      it { should == (0..50) }
    end

    context 'with :length option passed to constructor' do
      let(:attribute) { Attribute::String.new(:name, :length => 1..100) }

      it { should == (1..100) }
    end
  end
end
