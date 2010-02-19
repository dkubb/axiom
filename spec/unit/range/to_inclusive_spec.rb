require File.expand_path('../../../spec_helper', __FILE__)

describe 'Range#to_inclusive' do
  subject { @range.to_inclusive }

  describe 'on an exclusive Range' do
    describe 'with values that responds to #pred' do
      before do
        @range = 1...3
      end

      it 'should return an inclusive Range' do
        should == (1..2)
      end
    end

    describe 'with values that do not respond to #pred' do
      before do
        @range = 'a'...'z'
      end

      it { method(:subject).should raise_error(NoMethodError) }
    end
  end

  describe 'on an inclusive Range' do
    before do
      @range = 1..2
    end

    it 'should return self' do
      should equal(@range)
    end
  end
end
