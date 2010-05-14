require 'spec_helper'

describe 'Range#to_exclusive' do
  subject { range.to_exclusive }

  context 'on an exclusive Range' do
    let(:range) { 1...2 }

    it 'returns self' do
      should equal(range)
    end
  end

  context 'on an inclusive Range' do
    let(:range) { 1..2 }

    it 'returns an exclusive Range' do
      should == (1...3)
    end
  end
end
