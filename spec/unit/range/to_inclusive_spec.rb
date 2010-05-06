require File.expand_path('../../../spec_helper', __FILE__)

describe 'Range#to_inclusive' do
  subject { range.to_inclusive }

  describe 'on an exclusive Range' do
    describe 'with values that responds to #pred' do
      let(:range) { 1...3 }

      it 'returns an inclusive Range' do
        should == (1..2)
      end
    end

    describe 'with values that do not respond to #pred' do
      let(:range) { 'a'...'z' }

      it { method(:subject).should raise_error(NoMethodError) }
    end
  end

  describe 'on an inclusive Range' do
    let(:range) { 1..2 }

    it 'returns self' do
      should equal(range)
    end
  end
end
