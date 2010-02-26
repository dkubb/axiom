require File.expand_path('../../../../../spec_helper', __FILE__)

[ :size, :range ].each do |method|
  describe "Veritas::Attribute::Numeric##{method}" do
    subject { @attribute.send(method) }

    describe 'without :size option passed to constructor' do
      before do
        @attribute = Attribute::Numeric.new(:id)
      end

      it { should == (0..2**31-1) }
    end

    describe 'with :size option passed to constructor' do
      before do
        @attribute = Attribute::Numeric.new(:id, :size => 1..100)
      end

      it { should == (1..100) }
    end
  end
end
