require 'spec_helper'

describe 'Range#to_inclusive' do
  subject { range.to_inclusive }

  context 'on an exclusive Range' do
    context 'with values that responds to #pred' do
      let(:range) { 1...3 }

      it 'returns an inclusive Range' do
        should == (1..2)
      end
    end

    context 'with values that do not respond to #pred' do
      let(:range) { 'a'...'z' }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  context 'on an inclusive Range' do
    let(:range) { 1..2 }

    it 'returns self' do
      should equal(range)
    end
  end
end
