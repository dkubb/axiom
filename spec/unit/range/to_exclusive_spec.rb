require File.expand_path('../../../spec_helper', __FILE__)

describe 'Range#to_exclusive' do
  subject { @range.to_exclusive }

  describe 'on an exclusive Range' do
    before do
      @range = 1...2
    end

    it 'should return self' do
      should equal(@range)
    end
  end

  describe 'on an inclusive Range' do
    before do
      @range = 1..2
    end

    it 'should return an exclusive Range' do
      should == (1...3)
    end
  end
end
