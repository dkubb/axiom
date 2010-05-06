require File.expand_path('../../../../../spec_helper', __FILE__)

[ :size, :range ].each do |method|
  describe "Veritas::Attribute::Numeric##{method}" do
    subject { attribute.send(method) }

    describe 'without :size option passed to constructor' do
      let(:attribute) { Attribute::Numeric.new(:id) }

      it { should == (0..2**31-1) }
    end

    describe 'with :size option passed to constructor' do
      let(:attribute) { Attribute::Numeric.new(:id, :size => 1..100) }

      it { should == (1..100) }
    end
  end
end
