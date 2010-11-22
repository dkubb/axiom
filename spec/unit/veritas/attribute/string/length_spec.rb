require 'spec_helper'

[ :length, :range ].each do |method|
  describe "Veritas::Attribute::String##{method}" do
    subject { object.send(method) }

    let(:klass) { Attribute::String }

    context 'without :length option passed to constructor' do
      let(:object) { klass.new(:name) }

      it { should == (0..50) }
    end

    context 'with :length option passed to constructor' do
      let(:length) { 1..100                              }
      let(:object) { klass.new(:name, :length => length) }

      it { should == length }
    end
  end
end
