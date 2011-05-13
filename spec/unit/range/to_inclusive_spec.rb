# encoding: utf-8

require 'spec_helper'

describe Range, '#to_inclusive' do
  subject { object.to_inclusive }

  let(:object) { described_class.new(range_start, range_end, exclusive) }

  context 'on an exclusive Range' do
    let(:exclusive) { true }

    context 'with values that responds to #pred' do
      let(:range_start) { 1 }
      let(:range_end)   { 3 }

      it { should be_kind_of(described_class) }

      it 'returns an inclusive Range' do
        should == described_class.new(1, 2)
      end
    end

    context 'with values that do not respond to #pred' do
      let(:range_start) { 'a' }
      let(:range_end)   { 'z' }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  context 'on an inclusive Range' do
    let(:range_start) { 1     }
    let(:range_end)   { 2     }
    let(:exclusive)   { false }

    it 'returns self' do
      should equal(object)
    end
  end
end
