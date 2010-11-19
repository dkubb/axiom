require 'spec_helper'

describe 'Range#to_inclusive' do
  subject { object.to_inclusive }

  let(:klass) { Range }

  context 'on an exclusive Range' do
    context 'with values that responds to #pred' do
      let(:object) { 1...3 }

      it { should be_kind_of(klass) }

      it 'returns an inclusive Range' do
        should == (1..2)
      end
    end

    context 'with values that do not respond to #pred' do
      let(:object) { 'a'...'z' }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  context 'on an inclusive Range' do
    let(:object) { 1..2 }

    it 'returns self' do
      should equal(object)
    end
  end
end
