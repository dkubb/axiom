require 'spec_helper'

describe 'Veritas::Attribute#rename' do
  subject { attribute.rename(name) }

  let(:attribute) { Attribute::Integer.new(:id, :size => 1..10) }

  context 'when the new name is the same' do
    let(:name) { attribute.name }

    it { should equal(attribute) }
  end

  context 'when the new name is different' do
    let(:name) { :other_id }

    it { should be_kind_of(Attribute) }

    it { should_not equal(attribute) }

    its(:name) { should equal(name) }

    its(:options) { should equal(attribute.options) }
  end
end
